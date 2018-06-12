Received: from eggs.gnu.org ([2001:4830:134:3::10]:34807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdMi-0002l2-KJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdMf-0005rP-F6
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:05:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSdMf-0005qX-8f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0DFF814F0A3
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:05:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-5-dgilbert@redhat.com>
	<87efhdk1fg.fsf@dusky.pond.sub.org> <20180611174311.GO2661@work-vm>
Date: Tue, 12 Jun 2018 09:05:11 +0200
In-Reply-To: <20180611174311.GO2661@work-vm> (David Alan Gilbert's message of
	"Mon, 11 Jun 2018 18:43:12 +0100")
Message-ID: <87sh5swkm0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/7] qmp: enable
 query-[chardev|version|name|uuid|iothreads|memdev] commands in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
>> 
>> > From: Igor Mammedov <imammedo@redhat.com>
>> >
>> > subj commands, are informational and do not depend on machine being
>> > initialized. Make them available early in preconfig runstate to make
>> > the later a little bit more useful.
>> >
>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> 
>> Excessively long subject line.  Suggested fix:
>> 
>>     qmp: Enable a few query- commands in preconfig state
>> 
>>     Commands query-chardev, query-version, query-name, query-uuid,
>>     query-iothreads, query-memdev are informational and do not depend on
>>     the machine being initialized.  Make them available in preconfig
>>     runstate to make the latter a little bit more useful.
>> 
>> > ---
>> >  qapi/char.json |  3 ++-
>> >  qapi/misc.json | 12 +++++++-----
>> >  2 files changed, 9 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/qapi/char.json b/qapi/char.json
>> > index ae19dcd1ed..60f31d83fc 100644
>> > --- a/qapi/char.json
>> > +++ b/qapi/char.json
>> > @@ -62,7 +62,8 @@
>> >  #    }
>> >  #
>> >  ##
>> > -{ 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
>> > +{ 'command': 'query-chardev', 'returns': ['ChardevInfo'],
>> > +  'allow-preconfig': true }
>> 
>> Okay because
>> 
>>     if (qemu_opts_foreach(qemu_find_opts("chardev"),
>>                           chardev_init_func, NULL, NULL)) {
>>         exit(1);
>>     }
>> 
>> runs before -preconfig's main_loop().
>> 
>> >  
>> >  ##
>> >  # @ChardevBackendInfo:
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index f83a63a0ab..1be1728c0e 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -117,7 +117,8 @@
>> >  #    }
>> >  #
>> >  ##
>> > -{ 'command': 'query-version', 'returns': 'VersionInfo' }
>> > +{ 'command': 'query-version', 'returns': 'VersionInfo',
>> > +  'allow-preconfig': true }
>> 
>> Returns data fixed at compile time.  Okay.
>> 
>> >  
>> >  ##
>> >  # @CommandInfo:
>> > @@ -241,7 +242,7 @@
>> >  # <- { "return": { "name": "qemu-name" } }
>> >  #
>> >  ##
>> > -{ 'command': 'query-name', 'returns': 'NameInfo' }
>> > +{ 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
>> 
>> Okay because parse_name() runs before -preconfig's main_loop().
>> 
>> >  ##
>> >  # @KvmInfo:
>> > @@ -301,7 +302,7 @@
>> >  # <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
>> >  #
>> >  ##
>> > -{ 'command': 'query-uuid', 'returns': 'UuidInfo' }
>> > +{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
>> 
>> Okay because qemu_uuid(optarg, &qemu_uuid) runs before -preconfig's
>> main_loop().
>> 
>> >  
>> >  ##
>> >  # @EventInfo:
>> > @@ -710,7 +711,8 @@
>> >  #    }
>> >  #
>> >  ##
>> > -{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
>> > +{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
>> > +  'allow-preconfig': true }
>> 
>> Feeling lazy... why is this one okay?
>
> Because it's a walk of the entire object tree; with
> object_get_objects_root() - assuming the object tree exists we're safe.
>
>> >  
>> >  ##
>> >  # @BalloonInfo:
>> > @@ -2902,7 +2904,7 @@
>> >  #    }
>> >  #
>> >  ##
>> > -{ 'command': 'query-memdev', 'returns': ['Memdev'] }
>> > +{ 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
>> >  
>> >  ##
>> >  # @PCDIMMDeviceInfo:
>> 
>> And this one?
>
> Same trick as query-iothreads.

Thanks.
