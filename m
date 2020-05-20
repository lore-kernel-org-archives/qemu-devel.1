Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F21C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F2720671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw8l+wn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR7L-0007Nw-Mp
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbR53-0004Rb-Pu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:56:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbR4Y-0001jQ-TI
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589990158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ONIQ/4WJC8m0SB1A74C7/xvWqxaM4qhGOHwkhGVo5Q=;
 b=Jw8l+wn+1kTVcxZsKErMifm6nmj7jjBsPp2J2Sh1NMSkSva4qnkz7DqYQaU0RB7HjxZZP7
 1rFzTh0YNFMCqIRBGb6trJl9UGgECyrgOrXiaZkrYe0ZWSEwZ03lEAfXyTY4z2ra+pQV/h
 WS6FAHQ3py9E8aTHiUeK0XAN6yS1ynY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-XXjQcuOFPg2yLKUh7PLu6g-1; Wed, 20 May 2020 11:55:53 -0400
X-MC-Unique: XXjQcuOFPg2yLKUh7PLu6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93653835B41;
 Wed, 20 May 2020 15:55:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DB7D19631;
 Wed, 20 May 2020 15:55:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D93ED11358BC; Wed, 20 May 2020 17:55:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH v7] audio/jack: add JACK client audiodev
References: <20200505174520.CD62A3A021D@moya.office.hostfission.com>
 <87bln161ie.fsf@dusky.pond.sub.org>
 <b7dabe347553f76e9aa5d5473fe87b53@hostfission.com>
 <87tv0r0wbr.fsf@dusky.pond.sub.org>
 <43b316a9ad5212abe48b530f05306614@hostfission.com>
Date: Wed, 20 May 2020 17:55:47 +0200
In-Reply-To: <43b316a9ad5212abe48b530f05306614@hostfission.com> (Geoffrey
 McRae's message of "Fri, 08 May 2020 17:12:57 +1000")
Message-ID: <87r1vemwho.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I sincerely apologize for the excessive delay.

Geoffrey McRae <geoff@hostfission.com> writes:

> On 2020-05-08 16:34, Markus Armbruster wrote:
>> Geoffrey McRae <geoff@hostfission.com> writes:
>>
>>> On 2020-05-06 16:06, Markus Armbruster wrote:
>>>> You neglected to cc: the audio maintainer.  Doing that for you now.
>>>> You
>>>> can use scripts/get_maintainer.pl to find maintainers.
>>>
>>> Thanks, I was unaware.
>>
>> Happy to help :)
>>
>>>>
>>>> Find my QAPI schema review inline.
>>>>
>>>
>>> Ditto
>>>
>>>> Geoffrey McRae <geoff@hostfission.com> writes:
>>>>
>>>>> This commit adds a new audiodev backend to allow QEMU to use JACK as
>>>>> both an audio sink and source.
>>>>>
>>>>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>>>>> ---
>>>>>  audio/Makefile.objs    |   5 +
>>>>>  audio/audio.c          |   1 +
>>>>>  audio/audio_template.h |   2 +
>>>>>  audio/jackaudio.c      | 677
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>  configure              |  17 ++
>>>>>  qapi/audio.json        |  56 +++-
>>>>>  6 files changed, 756 insertions(+), 2 deletions(-)
>>>>>  create mode 100644 audio/jackaudio.c
>> [...]
>>>>> diff --git a/qapi/audio.json b/qapi/audio.json
>>>>> index c31251f45b..bdb0552d15 100644
>>>>> --- a/qapi/audio.json
>>>>> +++ b/qapi/audio.json
>>>>> @@ -152,6 +152,55 @@
>>>>>      '*out':     'AudiodevPerDirectionOptions',
>>>>>      '*latency': 'uint32' } }
>>>>>
>>>>> +##
>>>>> +# @AudiodevJackPerDirectionOptions:
>>>>> +#
>>>>> +# Options of the JACK backend that are used for both playback and
>>>>> +# recording.
>>>>> +#
>>>>> +# @server-name: select from among several possible concurrent
>>>>> server instances.
>>>>> +# If unspecified, use "default" unless $JACK_DEFAULT_SERVER is
>>>>> defined in the
>>>>> +# process environment.
>>>>
>>>> Suggest something like
>>>>
>>>>    # (default environment variable $JACK_DEFAULT_SERVER if set, else
>>>>    # "default").
>>
>> Uh, needs a colon after "(default" for clarity.
>>
>>>>
>>>
>>> I'd be happy to change this, however, this terminology reflects the
>>> JACK documentation which people already using JACK will be familiar
>>> with.
>>
>> There's a tension between your (sensible) desire to stay close to JACK
>> documentation, and our need for reasonably consistent QMP reference
>> documentation.
>>
>> Where we're talking about genuine JACK stuff, staying close to JACK
>> documentation feels more important.
>>
>> Where we're doing general QMP things, doing them the established QMP
>> way
>> feels more important.
>>
>> Phrasing "this is the optional member's default value" is QMP.  We
>> do it
>> all over the place like (default: WHATEVER).  Please stick to this
>> conventional QMP format.
>>
>> The WHATEVER is JACK stuff.  Feel free to improve on my suggested
>> phrasing there.
>>
>
> Not a problem, I will reword this as requested.
>
>>>>> +#
>>>>> +# @client-name: the client name to use. The server will modify
>>>>> this name to
>>>>> +# create a unique variant, if needed unless @exact_name is true.
>>>>
>>>> Do we really need this much magic?
>>>>
>>>> What would we lose with just @client-name?  If it's present, use
>>>> it as
>>>> is (no magic), else make up a client name.
>>>
>>> There is no magic on our part, this is how the JACK server works and
>>> is the default.
>>
>> Aha!
>>
>> Please bear with my ignorant questions...
>>
>> QEMU doesn'r have to expose everything the JACK library and server
>> provide, only the stuff that is useful to QEMU's users.
>>
>> There seem to be several variations:
>>
>> * @client-name absent, @exact_name false
>>
>>   JACK picks a name.
>>
>> * @client-name absent, @exact_name true
>>
>>   Error?  @exact_name silently ignored?
>>
>
> The @client-name is set to the VM's name as the default if absent.
>
>> * @client-name present, @exact_name false
>>
>>   JACK picks a name, using @client-name as inspiration somehow.
>>
>
> JACK picks a name only if there is a name clash, a duplicate,
> otherwise, it honours the requested name.
>
>> * @client-name present, @exact_name true
>>
>>   JACK uses @client-name if possible, else error.
>>
>> Use cases for the three variations that make sense?
>
> JACK is extremely configurable and is used in both general-purpose
> audio through to professional audio mastering and distribution in
> conferences and stadiums. As such all these use cases are completely
> valid and need to be present otherwise it limits the usefulness of
> this audio dev. The plumbing of jack is entirely left up to the user
> and as such there are countless different possible configurations and
> use cases.
>
>>
>> When letting JACK pick a name, how do users learn the name?
>
> We print it out if jack did this:
>
>     if (status & JackNameNotUnique) {
>         dolog("JACK unique name assigned %s\n",
>           jack_get_client_name(c->client));
>     }

Having to extract the name out of a log file is not machine-friendly.
Should we have some query-audio command?

> The user can also learn the name through various methods such as
> running `jack_lsp` or using `qjackctl`, or any number of potential
> jack plugboards such as `Carla`, etc.

How would I identify which of the possibly several names belongs to the
thing I set up via QMP?

>>>>> +#
>>>>> +# @connect-ports: if set, a regular expression of port name(s) to
>>>>> match to auto
>>>>> +# connect to at startup.
>>>>
>>>> Pardon my ignorance... where do the port names being matched come
>>>> from?
>>>
>>> Other JACK client ports. QEMU become a JACK client which has audio
>>> ports and can be patched into the system sound device, or any number
>>> of other ports for DSP.
>>
>> I think a slightly less terse doc comment would be a lot easier to
>> understand.  At least "s/ of port name(s)/of JACK client port name(s)/.
>> Also, "to auto connect to" is quite vague on what gets connected to
>> these ports.  Can we do a bit better?
>>
>
> The wording may need correcting however as jack is so flexible, what
> it gets connected to can not be stated. It could be anything depending
> on what clients/plugins the user are using already, the jack allows
> for a very complex and complete audio system. I have attached a
> screenshot of my JACK graph for a simple example of what this looks
> like.

Okay, I understand specifying here what JACK does makes no sense.  But
let's try to phrase what we can specify as clearly as possible.

[...]


