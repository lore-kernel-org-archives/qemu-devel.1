Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6DC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298BC2467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3iC93z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298BC2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwNvr-0008QN-7X
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwNv7-0007l1-GU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwNv4-0003aI-SS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:16:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwNv4-0003Yh-P7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580206589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paD2tWyGp7u+JV1ZYYUM0dyBEABXbS8Z4SWWWIrh29s=;
 b=Q3iC93z1uXypUj6r+iaKZJ7i8Sq5XLNwoWPc31Zyqi2npeY2N3Evqaq90uqaT0GK/Wa3z6
 SVelU/9F9Tb24X072mRWNaOqpwnWeFKji3Dh0aMCKn9+duUsbLJS0wgwY//5Gic96sn0j4
 y4UFGuWo3iblhWBUmahpBmov5rd0iGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-axT3xMiDMqWBvSJlLYJpxQ-1; Tue, 28 Jan 2020 05:16:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD1F8017CC;
 Tue, 28 Jan 2020 10:16:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5766F1001B08;
 Tue, 28 Jan 2020 10:16:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7D0A1138600; Tue, 28 Jan 2020 11:16:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <bd4a2839-69d6-697b-dc07-567ba08ce044@redhat.com>
Date: Tue, 28 Jan 2020 11:16:16 +0100
In-Reply-To: <bd4a2839-69d6-697b-dc07-567ba08ce044@redhat.com> (John Snow's
 message of "Mon, 27 Jan 2020 15:59:14 -0500")
Message-ID: <87y2trdgy7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: axT3xMiDMqWBvSJlLYJpxQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis
 V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/27/20 9:35 AM, Kevin Wolf wrote:
>> Am 24.01.2020 um 10:50 hat Daniel P. Berrang=C3=A9 geschrieben:
>>> On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
>>>> Well, sure. The context of this email was qmp-shell though, which is
>>>> meant to help facilitate the entry of JSON commands so that you *can*
>>>> indeed just forego the CLI/HMP entirely.
>>>>
>>>> If you are of the opinion that every user of QEMU should be copy/pasti=
ng
>>>> JSON straight into a socket and we should delete qmp-shell, that's
>>>> certainly a fine opinion.
>>>
>>> I think part of the pain of qmp-shell comes from the very fact that
>>> it is trying to be an interactive shell. This points people towards
>>> interactively typing in the commands, which is horrific when you get
>>> anywhere near the JSON, or even dot-notation traditional commands.
>>>
>>> If it was just a qmp-client that was single shot, we'd encourage
>>> people to create the JSON in a sensible way - vim/emacs/whatever.
>>=20
>> I don't see how this is sensible. QMP commands are something that I
>> reuse even less than VM configurations, so creating a one-off file for
>> each would take me a lot more time and I would still have to type the
>> same JSON code that I have to type with -qmp stdio.
>>=20
>> The reason it is and should be an interactive shell is that I'm
>> interacting with it. Switching back and forth between a text editor and
>> a shell to actually send the command to QEMU would make things only even
>> more cumbersome than they already are.
>>=20
>>> Bash/dash/zsh/$whatever is their interactive shell, with massively
>>> more features than qmp-shell. You have command history, autocomplete,
>>> conditional and looping constructs, and everything a normal shell
>>> offers.
>>=20
>> If I wanted to program a QMP client, I would use Python. For me,
>> conditionals and loops are completely out of scope for a QMP shell. I
>> just want an easy way to tell QEMU to do something specific.
>>=20
>> A command history already exists for qmp-shell. It's better than bash
>> because it doesn't mix QMP history with whatever else I do on my
>> computer.
>>=20
>> Autocomplete in qmp-shell doesn't exist, as far as I know, but if
>> implemented, it could be a lot more useful than bash completion because
>> it could offer key completion based on the QMP schema.
>>=20
>
> It does have tab completion for command names, but it does not know
> about or remember argument fields. It does not have autocomplete or
> typing hints like FiSH or bash ^r.
>
> I would like to change this, actually, by making the docstrings in QAPI
> schema a first class citizen of the spec and allowing them to be
> introspectable via the socket directly.
>
> (I.e., you can get the list of arguments and the docstrings that
> accompany them over the wire so you can display it in the client.)

You need doc strings for help, but not for completion.

query-qmp-schema's reply is already rather big: 130KiB.

The size of docs in an JSON encoding useful to qmp-shell we can only
estimate.  Plain text docs/interop/qemu-qmp-ref.txt is 505KiB.

I guess we'd make the doc strings optional.

> Problem I'm having with qmp-shell is, like Kevin says below ...
>
>> This is in fact a big part of the problem that qmp-shell really needs to
>> solve before it can replace HMP: How to make writing commands at least
>> almost as simple as with HMP. If I can just press tab a few times to
>> cycle through the available options for the command, that would already
>> be a massive improvement over writing JSON manually (which you would
>> still have to do with your text-file based approach, without any
>> QMP-specific support).
>>=20
>
> ... I can't figure out how to make writing commands simple.
>
> When you have a "simple" command, the abstraction works OK; you can type
> key=3Dval pairs and go about your way.

qmp-shell tries to improve on the JSON syntax by inventing its own,
but...

> As soon as you have anything nested, the gossamer-thin illusion is
> destroyed.

... it does a halfhearted job.

I'm deeply skeptical of any solution that starts with inventing a
new language.  Start with examining existing ones instead.

>            I investigated making this a little easier by adding a parser
> that could read directly from stdin and would allow multi-line JSON
> inputs as arguments.
>
> (Like the python shell does it, for example: When you have a dictionary
> opening brace, it lets you continue to the next line.)
>
> I was a little disheartened that most JSON parsers in python expect to
> consume buffered objects and generally consume the entire buffer -- it
> didn't seem to play nice with the idea of wanting to parse from STDIN
> directly.
>
>
> So:
>
> - I think qmp-shell is worth having, especially if polished
> (autocomplete, docstrings, argument hints, etc).
>
> - Kevin mentioned getting this into the GTK shell. I think that would be
> great, as a step to help phase out HMP.
>
> - I think getting rid of HMP is good because I don't care for the idea
> of supporting two monitor protocols. One schema, one parser, one truth.
>
> - I do, however, like the idea of having a non-rigorous monitor that
> lets us get away with murder when we need to. HMP is useful for
> debugging, prototypes and other things where the rigor and permanence of
> a QAPI schema feels too burdensome.

We discussed relaxing the rules for such QMP commands.  In particular,
they could return just a string.  Fine with me as long as we make
perfectly clear these commands are not stable interfaces.

> - So: maybe a turbocharged qmp-shell can offer some similar kinds of
> convenience commands that are build on top of real QMP. Sugar logic and
> other fanciful things could be implemented there in qmp-shell as
> extensions. You'd get a stock pile of them with your QEMU install that
> help you do certain tasks quickly and trivially.
>
> - Given all the above, I am willing to try to save, polish, or re-design
> qmp-shell; but am a bit starved for ideas on the syntax... This is why I
> was spending a bit of time talking about our flattening to dot syntax,
> and other projects related to representing hierarchical data.
>
> Would really love to hear ideas on what a good interactive shell syntax
> for a JSON-fueled schema would look like.

We can't possibly be the first ones asking this question.

> Any prior art, other projects, and reading anyone can recommend would be
> nice.
[...]


