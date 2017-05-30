Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFhSz-0002n1-He
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFhSw-0003DC-DP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFhSw-00039Z-5n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78D9FC0094F7
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:45:38 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<87poeqhdji.fsf@secure.mitica>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <9c89a465-1268-4213-2ae3-dd8f034b48a7@redhat.com>
Date: Tue, 30 May 2017 09:45:28 -0400
MIME-Version: 1.0
In-Reply-To: <87poeqhdji.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 05/30/2017 05:58 AM, Juan Quintela wrote:
> Vladislav Yasevich <vyasevic@redhat.com> wrote:
>> Add parameters that control RARP/GARP announcement timeouts.
>> The parameters structure is added to the QAPI and a qmp command
>> is added to set/get the parameter data.
>>
>> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> 
> Hi
> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f5e8194..cee2837 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -78,6 +78,104 @@ static struct mig_cmd_args {
>>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>>  };
>>  
> 
> Once that you are touching this, shouldn't it be better to be in
> net/<somewhere>?
> They have nothing to do with migration really.
> 

Yeah, I considered this, but could really find a good slot for them.
I can either put them into net.c directly or pull them out into their
own little file.

> 
>> +#define QEMU_ANNOUNCE_INITIAL    50
>> +#define QEMU_ANNOUNCE_MAX       550
>> +#define QEMU_ANNOUNCE_ROUNDS      5
>> +#define QEMU_ANNOUNCE_STEP      100
>> +
>> +AnnounceParameters *qemu_get_announce_params(void)
>> +{
>> +    static AnnounceParameters announce = {
>> +        .initial = QEMU_ANNOUNCE_INITIAL,
>> +        .max = QEMU_ANNOUNCE_MAX,
>> +        .rounds = QEMU_ANNOUNCE_ROUNDS,
>> +        .step = QEMU_ANNOUNCE_STEP,
>> +    };
>> +
>> +    return &announce;
>> +}
>> +
>> +void qemu_fill_announce_parameters(AnnounceParameters **to,
>> +                                   AnnounceParameters *from)
>> +{
>> +    AnnounceParameters *params;
>> +
>> +    params = *to = g_malloc0(sizeof(*params));
>> +    params->has_initial = true;
>> +    params->initial = from->initial;
>> +    params->has_max = true;
>> +    params->max = from->max;
>> +    params->has_rounds = true;
>> +    params->rounds = from->rounds;
>> +    params->has_step = true;
>> +    params->step = from->step;
>> +}
>> +
>> +bool qemu_validate_announce_parameters(AnnounceParameters *params, Error **errp)
>> +{
>> +    if (params->has_initial &&
>> +        (params->initial < 1 || params->initial > 100000)) {
> 
> This is independent of this patch, but we really need a macro:
>   CHECK(field, mininum, maximum)
> 
> We repeat this left and right.
> 
>> +void qemu_set_announce_parameters(AnnounceParameters *announce_params,
>> +                                  AnnounceParameters *params)
> 
>> +void qmp_announce_set_parameters(AnnounceParameters *params, Error **errp)
> 
> Really similar functions name.  I assume by know that the 1st function
> is used somewhere else in the series.
> 

Yes, the first function is going to be used later.

Thanks
-vlad
