Received: from eggs.gnu.org ([209.51.188.92]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3DJR-0001IU-KP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3D5u-00084Q-Ms
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:03:24 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:37488 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3D5t-00082E-JO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:03:22 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
	by postfix.smtp2.imsva2 (Postfix) with ESMTPS id D8741BFF4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:03:17 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 531485A054
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:03:17 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 483085A051
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:03:17 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
	by imsva2.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:03:17 +0100 (CET)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54]) by smtp2 (Postfix) with ESMTPSA id 090B0120B6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:03:16 +0100 (CET)
Received: by mail-io1-f54.google.com with SMTP id p17so2873581iol.7
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 22:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190306031221.GA53@03612eec87fc>
	<20190306045252.GG75@03612eec87fc>
	<aa7609b9-be37-6a50-7471-20e814051dac@vivier.eu>
In-Reply-To: <aa7609b9-be37-6a50-7471-20e814051dac@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 06:03:06 +0100
Message-ID: <CAGZZdDEOkb_Gd1Co6s=UnrayODOyow5ELCTGLjNNM+hQxa=OyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/10] qemu-binfmt-conf.sh: add option
 --reset <ARCHS>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

2019/3/10 18:15, Laurent Vivier:
> On 06/03/2019 05:52, Unai Martinez-Corral wrote:
> > Allows to remove a single or a list of already registered binfmt
> > interpreters. If <ARCHS> is a list, it must be comma-separated.
>
> I think ARCHS and CPUS are the same thing, so use the same word.

They are similar, but the syntax is not the same. ARCHS supports a
single word or a comma separated list. CPUS supports also using
spaces, tabs, etc. as separators.

> > -Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd]
> > -                           [--help][--credential][--exportdir PATH]
> > +Usage: qemu-binfmt-conf.sh [--help][--path PATH][--debian][--systemd]
> > +                           [--reset ARCHS][--credential][--exportdir P=
ATH]
> >                             [--persistent][--suffix SUFFIX][CPUS]
>
> I don't like the idea of being able to set and reset different
> interpretes with same command line call.

> Make "--reset" exclusive without parameter to be able to use the common
> cpu list at the end of the command line

It is useful in order to replace a single interpreter or a few of them
in a single call to the script. Anyway, I think that your comment
makes sense. It is enough if we support to reset a subset. Any user
can then wrap two consecutive calls in a helper function.

So, in the next version '--reset' will be 'exclusive', i.e., it will
prevent registration.

> (this way, I think you would be
> able to share more common code between setting an resetting).

The shared code is the same, because 'qemu_check_target_list' was
already being used in both. The simplification comes from the fact
that we do not support commas anymore, since ARCHS and CPUS are now
only positional.

> You could have a look to Alex Benn=C3=A9e's patch:
>
>   https://patchwork.ozlabs.org/patch/938796/
>
> I think this is the good way to do this and it should merge easily with
> your series.

Thanks for the reference; I had skipped it. Upon further inspection, I
think that the features proposed by Alex are already implemented in
this patch, or they will be in the next version:

- I am already checking with '$CHECK', which will use the
corresponding procedure depending on 'systemd' or 'debian'.
- I am using printf instead of 'echo -1', as suggested by Eric Blake
in v1 of the patch.
- I will rename the option from '--reset' to '--clear', as I find it
to be more descriptive.
- None of us support neither '--debian' nor '--systemd'. See comments below=
.
- I support providing a subset of targets, while Alex' approach
targeted all of them.
- Overall, I think that 'BINFMT_SET=3Dqemu_clear_interpreter' is ok for
a proof of concept, but it is not as clean as it could be. Precisely,
all the magic, mask, family values are computed in the loop inside
qemu_set_binfmts. That should be avoided if we only want to remove
them. Nonetheless, I will try to integrate both approaches.

Regarding this comment:

> I think it would be also useful to remove the files from $EXPORTDIR.
> So could you also manage something like "--debian --clear" and "--systemd=
 CPU --clear"?

ATM, this patchset supports '--reset --debian' or '--reset --systemd',
but it will proceed by updating /proc directly, which might not be
effective at all.
Furthermore, when '--debian --reset' or '--systemd --reset' are used,
a error message is shown: 'ERROR: option reset not implemented for
this mode yet'.

On the one hand, I can make '--reset --debian|systemd' and
'--debian|systemd --reset' consistent, by delaying the execution of
the reset/clear function after all the options are parsed.

On the other hand, I'd really like to have patches 6 and 7 available
in QEMU 4.0, if possible. So, I'd like to know if the partial
implementation of this feature is a stopper. If so, I'd be so glad to
have some help. These are the prototypes that I have not added to the
patchset because I am not sure about them:

For the debian case, after the comments in 'usage()', I think that the
procedure should be:

for t in $qemu_check_target_list ; do
  sudo update-binfmts --package "qemu-$t" --remove "qemu-$t" "$QEMU_PATH"
  rm "$EXPORTDIR/qemu-$t"
done

And for systemd:

sudo systemctl stop systemd-binfmt.service
for t in $qemu_check_target_list ; do
   rm -rf $EXPORTDIR/qemu-$t.conf"
do
sudo systemctl start systemd-binfmt.service

Thanks,
Unai
