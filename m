Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFieE-0002Nw-Gq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFieB-0002su-Dk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFieB-0002sV-1K
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 723DC81243
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:01:21 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-7-git-send-email-vyasevic@redhat.com>
	<20170530141400.GP21566@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <d820a362-8d5d-66d6-2f5b-77f614e03370@redhat.com>
Date: Tue, 30 May 2017 11:01:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170530141400.GP21566@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com, jdenemar@redhat.com

On 05/30/2017 10:14 AM, Daniel P. Berrange wrote:
> On Wed, May 24, 2017 at 02:05:22PM -0400, Vladislav Yasevich wrote:
>> Add a qmp command that can trigger guest announcements.
>>
>> Based on work of Germano Veit Michel <germano@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>> ---
>>  migration/savevm.c | 14 ++++++++++++++
>>  qapi-schema.json   | 19 +++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index a4097c9..b55ce6a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -265,6 +265,20 @@ void qemu_announce_self(AnnounceParameters *params)
>>      qemu_announce_self_once(timer);
>>  }
>>  
>> +void qmp_announce_self(bool has_params, AnnounceParameters *params,
>> +                       Error **errp)
>> +{
>> +    AnnounceParameters announce_params;
>> +
>> +    memcpy(&announce_params, qemu_get_announce_params(),
>> +           sizeof(announce_params));
>> +
>> +    if (has_params)
>> +        qemu_set_announce_parameters(&announce_params, params);
>> +
>> +    qemu_announce_self(&announce_params);
>> +}
> 
> I'm not a huge fan of the idea of setting announce parameters in a
> global namespace, via a previously issued separate command.
> 
> I realize this is already done for the 'migrate' command, but there
> it has been the cause of a number of bugs in libvirt mgmt of QEMU.
> At least with migrate it makes sense for some parameters which need
> to be tuned 'on the fly' after migrate already started. That doesn't
> apply to this command though.
> 
> So I tend to think it'd be nicer to just make the parameters mandatory
> for this command, so it is self-contanied does and not rely on previously
> set (or potentially unknown/indeterminate) global state.
> 

The reason I didn't do this is that I didn't want to require the user
to know or even think about the timeout values. I did want to provide
an option though for those who may want to tweak things.  In most circumstances,
the timeout values would never really be touched and we'll just use the
qemu defaults.  in rare circumstances, values might need to be changed
during migration.  Here, I can definitely see the need to give migration
it's own values.


> I'd also suggest that instad of adding an 'announce_set_parameters',
> the parameters for the automatic announce at end of migration should
> be set via the 'migrate_set_parameters' command.

I can do that.

> 
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 2030087..126b09d 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -654,6 +654,25 @@
>>    'returns': 'AnnounceParameters' }
>>  
>>  ##
>> +# @announce-self:
>> +#
>> +# Trigger generation of broadcast RARP frames to update network switches.
>> +# This can be useful when network bonds fail-over the active slave.
>> +#
>> +# Arguments: None.
> 
> "None", but it has some arguments listed right below....

will fix


Thanks
-vlad

> 
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "announce-self"
>> +#      "arguments": { "announce-rounds": 5 } }
>> +# <- { "return": {} }
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'command': 'announce-self',
>> +  'data' : {'*params': 'AnnounceParameters'} }
>> +
>> +##
>>  # @MigrationStats:
>>  #
>>  # Detailed migration status.
>> -- 
>> 2.7.4
>>
>>
> 
> Regards,
> Daniel
> 
