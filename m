Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8385C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CF52071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHXmdWpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CF52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivIXS-0006ye-Pv
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 05:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ivIWp-0006WQ-LV
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ivIWm-0005Op-6f
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:18:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ivIWl-0005La-Es
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579947534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WRv9ODSlX03A9NWaLcXO2uCySVar0Lp3L58KeldHZ0=;
 b=WHXmdWpHTxkO3G3N+QZP8htio5PSmtEIXUoVc9zaeXQgflZYW/iBxbhGRMzIwNRIcqGq42
 6VIQfhw3E9CSrAOVonENeWzKQzbJbNz+oiH5rqWSNgb6nmXyfmV+o07qplPfd3M45BQjG5
 o+YyFqamBKqtDdO4yoy5Ba5YQBUX3R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-3sJWwEfPMB2W2DmVIa3aAw-1; Sat, 25 Jan 2020 05:18:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A88A800D4E;
 Sat, 25 Jan 2020 10:18:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F01510016E8;
 Sat, 25 Jan 2020 10:18:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C84921138600; Sat, 25 Jan 2020 11:18:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
Date: Sat, 25 Jan 2020 11:18:41 +0100
In-Reply-To: <20200124143841.GG4732@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 24 Jan 2020 15:38:41 +0100")
Message-ID: <87sgk3x2im.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3sJWwEfPMB2W2DmVIa3aAw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 24.01.2020 um 11:27 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Fri, Jan 24, 2020 at 08:59:41AM +0100, Markus Armbruster wrote:
>> > John Snow <jsnow@redhat.com> writes:
>> >=20
>> > > On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
>> > >> So when configuring objects you'll always provide a JSON/YAML doc.
>> > >> They've got some clever stuff for updating objects where you can
>> > >> provide a JSON patch for only the bits which need changing.
>> > >>=20
>> > >> When querying/listing objects by default it displays only a small
>> > >> subset of their config information in a human friendly-ish format.
>> > >> If you want to see everything then you ask for it in JSON/YAML
>> > >> format. There's also an expression language that lets you extract
>> > >> particular pieces of information based on requested properties,
>> > >> and you can filter the list of objects based on attributes and so
>> > >> on.
>> > >>=20
>> > >> I think it is fair to say the structure of kubernetes object config
>> > >> is on a par with hierarchical complexity of QEMU. The lack of a sim=
ple
>> > >> human targetted data input format does not appear to have negativel=
y
>> > >> impacted the adoption of Kubernetes. It is worth questioning why th=
is
>> > >> is the case, while we feel the human CLI syntax for QEMU is so
>> > >> critically important to QEMU's future ?
>> >=20
>> > I consider human CLI syntax for QEMU a mostly solved *design* problem:
>> > dotted keys.  It's an unsolved *implementation* problem: the CLI is a
>> > tangled mess of almost two decades' worth of ideas, and only (some of)
>> > the latest strands actually use dotted keys infrastructure.  The
>> > proposed solution is CLI QAPIfication.  Gives us configuration file(s)
>> > and introspection.
>> >=20
>> > Dotted keys are merely yet another concrete syntax.  They're designed =
to
>> > satisfy the CLI requirements we have, which include a measure of
>> > compatibility to what's in the tangled mess.  They're reasonably usabl=
e
>> > for simple stuff, but complex stuff can be too verbose to be readable.
>> > They can't express all of the abstract syntax.  Tolerable, since they
>> > provide an escape to JSON.  I recommend programs use the JSON escape
>> > always.  Awkward for humans due to shell quoting.
>>=20
>> I agree that the dotted key syntax is our chosen / solved design
>> for expressing JSON on the CLI. I would also say that, in retrospect,
>> this was a incorrect design decision that is one of the key things
>> responsible for QEMU having a bad reputation for complexity.
>
> I doubt this. Whenever I get a bug report with a command line created by
> libvirt, the command line is huge, but basically nothing in it uses
> dotted syntax. Yes, you may have cache.direct=3Don in it somewhere, but
> that's not actual nesting.
>
> The problem is the amount of options that is specified by management
> tools, and then humans are looking at it and feel it's way too complex.
>
> Command lines written by human users are usually much simpler because
> they just use QEMU's defaults instead of explicitly specifying
> everything.

Yes, machine-generated configuration is more verbose than what humans
produce.  Machines like it explicit.  It's simpler for them than relying
on defaults.  Bonus: immunity to changing defaults.

But no, verbosity is not the core problem, it merely aggravates the core
problem.  Complex configuration is much harder to read in a CLI syntax
than in a half-decent config file.  Yes, it's prohibitively harder just
for lengthy configurations.  That doesn't make it not harder for short
configurations.

>> We should simply never have tried to invent a way to map the full
>> hiearchy of JSON onto the CLI as the result will always be unpleasant.

It's what I had to do to secure a beach head for QAPI on the command
line coast.

>> The dotted notation is the most verbose way to do this type of
>> configuration, because of the string repetition it requires for
>> nested structures.
>
> True. I would have liked a different syntax that used some kind of
> brackets (at least optionally), but Markus didn't like adding another
> character that must be escaped.

Design thread:

    Subject: Non-flat command line option argument syntax
    Date: Thu, 02 Feb 2017 20:42:33 +0100
    Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00555.html

A few quick quotes:

* On JSON vs. dotted keys in CLI: "both variants are basically
  illegible.  This is simply something that belongs into a config file
  rather than the command line.  In a config file, JSON would be a
  better choice."

* On dotted keys vs. structured values: "dotted keys are weird and ugly,
  but at least they don't add to the quoting mess.  Structured values
  look better, except when they do add to the quoting mess.  I'm having
  a hard time deciding which one I like less :)"

* Final verdict: "the whole non-flat command line argument design has
  been an exercise in picking what I dislike least."

> I think if we want, we can still evolve our human syntax to be more user
> friendly. My impression was that we don't want to.

Correct.

Quote from the design thread on disambiguating scalars, but I feel the
gist of it applies more widely:

    * When it breaks, fall back to JSON

      Tolerable if it breaks pretty much only in obscure corner cases.

    * More syntax

      Add syntax to disambiguate the type (key sigils?).  Has to be optiona=
l
      for backward compatibility reasons.  When omitting type information
      breaks, you have to supply it, or fall back to JSON.

      More syntax for use in obscure cases is about the last thing the QEMU
      command line needs.

    * More magic

      Make the keyval variant of the QObject input visitor shift the
      breakage to hopefully less common cases.

      - Empty list magic

        When the visitor is asked for a list, and the list's key wasn't
        specified, return an empty list instead of failure.  Unbreaks empty
        list, breaks absent optional list.

      - Alternate magic

        When the visitor is asked for an alternate, pick the alternate's
        variant based on the value rather than the type for scalar values
        (the type is always 'str' then).  Unbreaks alternates when this
        picks the variant you want, breaks them when you really want 'str'.

      - Possibly more

      When the magic breaks, fall back to JSON.

      More magic in the QEMU command line feels even worse to me than more
      syntax.

>> Lets consider how libvirt uses blockdev for a LUKS volume stored
>> in iSCSI
>>=20
>>   $ qemu-system-x86_64 \
>>   -object secret,id=3Dlibvirt-5-storage-secret0,\
>>     data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6=
j/1,\
>>     keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64=
 \
>>   -object secret,id=3Dlibvirt-5-format-luks-secret0,\
>>     data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6=
j/1,\
>>     keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64=
 \
>>   -blockdev '{"driver":"iscsi","portal":"example.org:6000",\
>>     "target":"iqn.1992-01.com.example:storage","lun":1,"transport":"tcp"=
,\
>>     "user":"myname","password-secret":"libvirt-5-storage-secret0",\
>>     "node-name":"libvirt-5-storage","auto-read-only":true,"discard":"unm=
ap"}' \
>>   -blockdev '{"node-name":"libvirt-5-format","read-only":false,"driver":=
"qcow2",\
>>     "encrypt":{"format":"luks","key-secret":"libvirt-5-format-luks-secre=
t0"},\
>>     "file":"libvirt-5-storage"}' \
>>=20
>> We all know JSON is horrible on the CLI, no surprise. So
>>=20
>> Lets use human "friendly" dotted syntax instead:
>>=20
>>   $ qemu-system-x86_64 \
>>   -object secret,id=3Dlibvirt-5-storage-secret0,\
>>     data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6=
j/1,\
>>     keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64=
 \
>>   -object secret,id=3Dlibvirt-5-format-luks-secret0,\
>>     data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6=
j/1,\
>>     keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64=
 \
>>   -blockdev driver=3Dqcow2,node-name=3Dlibvirt-5-format,read-only=3Dfals=
e,\
>>     encrypt.format=3Dluks,encrypt.key-secret=3Dlibvirt-5-format-luks-sec=
ret0,\
>>     file.driver=3Discsi,file.portal=3Dexample.org:6000,\
>>     file.target=3Diqn.1992-01.com.example:storage,file.lun=3D1,file.tran=
sport=3Dtcp,\
>>     file.user=3Dmyname,file.password-secret=3Dlibvirt-6-storage-secret0,=
\
>>     file.node-name=3Dlibvirt-5-storage,file.auto-read-only=3Dtrue,file.d=
icard=3Dunmap
>>=20
>> I don't think that's much of an improvement, aside from not having
>> to worry about matching "}".
>
> I see you merged the two -blockdev arguments into a single one in order
> to get at least some repetition with the file.* prefixes. ;-)
>
>> If we move to JSON in a config file
>>=20
>>   $ cat qemu.json
>>   {
>>     "arguments": [
>>       {
>>         "arg": "object",
>>         "data": {
>>           "type": "secret",
>>           "id":"libvirt-5-storage-secret0",
>>           "data": "9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM=
91uEHCn6j/1",
>>           "keyid": "masterKey0",
>>           "iv": "AAECAwQFBgcICQoLDA0ODw=3D=3D",
>>           "format": "base64"
>>         }
>>       },
>>       {
>>         "arg": "object",
>>         "data": {
>>           "type": "secret",
>>           "id":"libvirt-5-format-luks-secret0",
>>           "data": "9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM=
91uEHCn6j/1",
>>           "keyid": "masterKey0",
>>           "iv": "AAECAwQFBgcICQoLDA0ODw=3D=3D",
>>           "format": "base64"
>>         }
>>       },
>>       {
>>         "arg": "blockdev",
>>         "data": {
>>           "node-name":"libvirt-5-format",
>>           "read-only":false,"driver":"qcow2",
>>           "encrypt":{
>>             "format":"luks","key-secret":
>>             "libvirt-5-format-luks-secret0"
>>           },
>>           "file":{
>>             "driver": "iscsi",
>>             "portal": "example.org:6000",
>>             "target":"iqn.1992-01.com.example:storage",
>>             "lun": 1,
>>             "transport": "tcp",
>>             "user": "myname",
>>             "password-secret": "libvirt-5-storage-secret0",
>>             "node-name":"libvirt-5-storage",
>>             "auto-read-only":"true",
>>             "discard":"unmap"
>>           }
>>         }
>>       }
>>     ]
>>   }
>>   $ qemu-system-x86_64 -f qemu.json
>>=20
>> The config file is more volumous than the CLI, but it is also
>> massively more intelligible to humans because you can see the
>> structure of the data.
>>=20
>> I still screwed up many times with missing quotes, incorrect
>> commas, etc. All the fun of JSON
>
> JSON is usually easy enough to read, quite reasonable for making minor
> modifications, and a PITA for writing something (like a QMP request)
> from scratch.

JSON is by design a data interchange format.  We (and others) pressed it
into a configuration file role.  PITA ensues.  Crockford shrugs.

Suitable tooling can reduce it.

>> So if we allowed YAML instead of JSON, now we get...
>>=20
>>   $ cat qemu.yaml
>>   ---
>>   arguments:
>>   - arg: object
>>     data:
>>       type: secret
>>       id: libvirt-5-storage-secret0
>>       data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn=
6j/1
>>       keyid: masterKey0
>>       iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
>>       format: base64
>>   - arg: object
>>     data:
>>       type: secret
>>       id: libvirt-5-format-luks-secret0
>>       data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn=
6j/1
>>       keyid: masterKey0
>>       iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
>>       format: base64
>>   - arg: blockdev
>>     data:
>>       node-name: libvirt-5-format
>>       read-only: false
>>       driver: qcow2
>>       encrypt:
>>         format: luks
>>         key-secret: libvirt-5-format-luks-secret0
>>       file:
>>         driver: iscsi
>>         portal: example.org:6000
>>         target: iqn.1992-01.com.example:storage
>>         lun: 1
>>         transport: tcp
>>         user: myname
>>         password-secret: libvirt-5-storage-secret0
>>         node-name: libvirt-5-storage
>>         auto-read-only: true
>>         discard: unmap
>>   $ qemu-system-x86_64 -f qemu.yaml
>>=20
>> This is finally something I'd consider to be on a par with the
>> original QEMU syntax, before we added hierarchical data. You
>> have the minimal possible amount of syntax here. No commas,
>> no quotes, no curly brackets, etc.
>
> This seems to have the same problems as the QEMU command line (how do
> you distinguish strings from ints, from bools, from null?).

True: YAML provides only string scalars.

TOML provides strings, integers, floats, booleans, and several flavors
of time.  It lacks null.

>                                                             It's
> basically just a pretty-printed version of it with the consequence that
> it needs to be stored in an external file and there is no reasonable way
> to keep it in my shell history.

There is a reasonable way to keep it in my file system, though.  I find
that decidedly superior.

[...]


