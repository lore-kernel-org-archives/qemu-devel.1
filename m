Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E3C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4615207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1IzwzjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4615207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwbO-0001CE-1U
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwaJ-0008Pf-Bz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:34:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwaI-0007DE-7R
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiYZHv6Cl1ZwVaRlf9NcD8lGf4S088smW/Z64tEUvVs=;
 b=D1IzwzjO9R6MClH25s9/AIAAvD+vVVxvj+E8e86uo3Bg0jB6bhGT8vQa9CYZ9c5i8x4aD+
 367hLfxkm8RChjAZgv5H5kiBYmXnp1Y1fyTJDVd3bxx9hJDxj4YFiDDMH+WdmfMbPpDmL+
 1UE5l+W+TQw7elq50Wt/bRcHbZBuvKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-N6j-aTA6P1ya1GTsMO0eNA-1; Fri, 08 May 2020 02:34:06 -0400
X-MC-Unique: N6j-aTA6P1ya1GTsMO0eNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3A119067F0;
 Fri,  8 May 2020 06:34:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42D2E10016EB;
 Fri,  8 May 2020 06:34:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB62A11358BC; Fri,  8 May 2020 08:34:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH v7] audio/jack: add JACK client audiodev
References: <20200505174520.CD62A3A021D@moya.office.hostfission.com>
 <87bln161ie.fsf@dusky.pond.sub.org>
 <b7dabe347553f76e9aa5d5473fe87b53@hostfission.com>
Date: Fri, 08 May 2020 08:34:00 +0200
In-Reply-To: <b7dabe347553f76e9aa5d5473fe87b53@hostfission.com> (Geoffrey
 McRae's message of "Wed, 06 May 2020 16:13:33 +1000")
Message-ID: <87tv0r0wbr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Geoffrey McRae <geoff@hostfission.com> writes:

> On 2020-05-06 16:06, Markus Armbruster wrote:
>> You neglected to cc: the audio maintainer.  Doing that for you now.
>> You
>> can use scripts/get_maintainer.pl to find maintainers.
>
> Thanks, I was unaware.

Happy to help :)

>>
>> Find my QAPI schema review inline.
>>
>
> Ditto
>
>> Geoffrey McRae <geoff@hostfission.com> writes:
>>
>>> This commit adds a new audiodev backend to allow QEMU to use JACK as
>>> both an audio sink and source.
>>>
>>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>>> ---
>>>  audio/Makefile.objs    |   5 +
>>>  audio/audio.c          |   1 +
>>>  audio/audio_template.h |   2 +
>>>  audio/jackaudio.c      | 677
>>> +++++++++++++++++++++++++++++++++++++++++
>>>  configure              |  17 ++
>>>  qapi/audio.json        |  56 +++-
>>>  6 files changed, 756 insertions(+), 2 deletions(-)
>>>  create mode 100644 audio/jackaudio.c
[...]
>>> diff --git a/qapi/audio.json b/qapi/audio.json
>>> index c31251f45b..bdb0552d15 100644
>>> --- a/qapi/audio.json
>>> +++ b/qapi/audio.json
>>> @@ -152,6 +152,55 @@
>>>      '*out':     'AudiodevPerDirectionOptions',
>>>      '*latency': 'uint32' } }
>>>
>>> +##
>>> +# @AudiodevJackPerDirectionOptions:
>>> +#
>>> +# Options of the JACK backend that are used for both playback and
>>> +# recording.
>>> +#
>>> +# @server-name: select from among several possible concurrent
>>> server instances.
>>> +# If unspecified, use "default" unless $JACK_DEFAULT_SERVER is
>>> defined in the
>>> +# process environment.
>>
>> Suggest something like
>>
>>    # (default environment variable $JACK_DEFAULT_SERVER if set, else
>>    # "default").

Uh, needs a colon after "(default" for clarity.

>>
>
> I'd be happy to change this, however, this terminology reflects the
> JACK documentation which people already using JACK will be familiar
> with.

There's a tension between your (sensible) desire to stay close to JACK
documentation, and our need for reasonably consistent QMP reference
documentation.

Where we're talking about genuine JACK stuff, staying close to JACK
documentation feels more important.

Where we're doing general QMP things, doing them the established QMP way
feels more important.

Phrasing "this is the optional member's default value" is QMP.  We do it
all over the place like (default: WHATEVER).  Please stick to this
conventional QMP format.

The WHATEVER is JACK stuff.  Feel free to improve on my suggested
phrasing there.

>>> +#
>>> +# @client-name: the client name to use. The server will modify
>>> this name to
>>> +# create a unique variant, if needed unless @exact_name is true.
>>
>> Do we really need this much magic?
>>
>> What would we lose with just @client-name?  If it's present, use it as
>> is (no magic), else make up a client name.
>
> There is no magic on our part, this is how the JACK server works and
> is the default.

Aha!

Please bear with my ignorant questions...

QEMU doesn'r have to expose everything the JACK library and server
provide, only the stuff that is useful to QEMU's users.

There seem to be several variations:

* @client-name absent, @exact_name false

  JACK picks a name.

* @client-name absent, @exact_name true

  Error?  @exact_name silently ignored?

* @client-name present, @exact_name false

  JACK picks a name, using @client-name as inspiration somehow.

* @client-name present, @exact_name true

  JACK uses @client-name if possible, else error.

Use cases for the three variations that make sense?

When letting JACK pick a name, how do users learn the name?

>>> +#
>>> +# @connect-ports: if set, a regular expression of port name(s) to
>>> match to auto
>>> +# connect to at startup.
>>
>> Pardon my ignorance... where do the port names being matched come from?
>
> Other JACK client ports. QEMU become a JACK client which has audio
> ports and can be patched into the system sound device, or any number
> of other ports for DSP.

I think a slightly less terse doc comment would be a lot easier to
understand.  At least "s/ of port name(s)/of JACK client port name(s)/.
Also, "to auto connect to" is quite vague on what gets connected to
these ports.  Can we do a bit better?

>>> +#
>>> +# @start-server: set to true to start a jack server instance if
>>> one is not
>>> +# present.

Default?

>>
>> Is this an external server program?
>
> Yes, the jack library can start the jack server much like PulseAudio
> auto spawns a process on most systems. People using JACK will be
> familiar with this already.

Replace "server instance" by "server process"?

>>> +#
>>> +# @exact-name: use the exact name requested otherwise JACK
>>> automatically
>>> +# generates a unique one, if needed.

Default?

>>> +#
>>> +# Since: 5.1
>>> +##
>>> +{ 'struct': 'AudiodevJackPerDirectionOptions',
>>> +  'base': 'AudiodevPerDirectionOptions',
>>> +  'data': {
>>> +    '*server-name':   'str',
>>> +    '*client-name':   'str',
>>> +    '*connect-ports': 'str',
>>> +    '*start-server':  'bool',
>>> +    '*exact-name':    'bool' } }
>>> +
>>> +##
>>> +# @AudiodevJackOptions:
>>> +#
>>> +# Options of the JACK audio backend.
>>> +#
>>> +# @in: options of the capture stream
>>> +#
>>> +# @out: options of the playback stream
>>> +#
>>> +# Since: 5.1
>>> +##
>>> +{ 'struct': 'AudiodevJackOptions',
>>> +  'data': {
>>> +    '*in':  'AudiodevJackPerDirectionOptions',
>>> +    '*out': 'AudiodevJackPerDirectionOptions' } }
>>> +
>>>  ##
>>>  # @AudiodevOssPerDirectionOptions:
>>>  #
>>> @@ -297,11 +346,13 @@
>>>  #
>>>  # An enumeration of possible audio backend drivers.
>>>  #
>>> +# @jack: JACK audio backend (since 5.1)
>>> +#
>>>  # Since: 4.0
>>>  ##
>>>  { 'enum': 'AudiodevDriver',
>>> -  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa',
>>> 'sdl',
>>> -            'spice', 'wav' ] }
>>> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'jack', 'oss',
>>> 'pa',
>>> +            'sdl', 'spice', 'wav' ] }
>>>
>>>  ##
>>>  # @Audiodev:
>>> @@ -327,6 +378,7 @@
>>>      'alsa':      'AudiodevAlsaOptions',
>>>      'coreaudio': 'AudiodevCoreaudioOptions',
>>>      'dsound':    'AudiodevDsoundOptions',
>>> +    'jack':      'AudiodevJackOptions',
>>>      'oss':       'AudiodevOssOptions',
>>>      'pa':        'AudiodevPaOptions',
>>>      'sdl':       'AudiodevGenericOptions',


