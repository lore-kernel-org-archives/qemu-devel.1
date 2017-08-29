Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ydary@redhat.com>) id 1dmcnO-0000Lf-AN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ydary@redhat.com>) id 1dmcnK-0005fk-A7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:26:54 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ydary@redhat.com>) id 1dmcnJ-0005eU-V9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:26:50 -0400
Received: by mail-lf0-f53.google.com with SMTP id y128so5486086lfd.4
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:26:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
	<923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
From: "Yaniv Lavi (Dary)" <ylavi@redhat.com>
Date: Tue, 29 Aug 2017 12:26:06 +0300
Message-ID: <CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "Mureinik, Allon" <amureini@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Tal Nisan <tnisan@redhat.com>

YANIV LAVI (YANIV DARY)

SENIOR TECHNICAL PRODUCT MANAGER

Red Hat Israel Ltd. <https://www.redhat.com/>

34 Jerusalem Road, Building A, 1st floor

Ra'anana, Israel 4350109

ylavi@redhat.com    T: +972-9-7692306/8272306     F: +972-9-7692223    IM: ylavi
 <https://red.ht/sig> TRIED. TESTED. TRUSTED. <https://redhat.com/trusted>
@redhatnews <https://twitter.com/redhatnews>   Red Hat
<https://www.linkedin.com/company/red-hat>   Red Hat
<https://www.facebook.com/RedHatInc>


On Mon, Aug 28, 2017 at 9:11 PM, John Snow <jsnow@redhat.com> wrote:

>
>
> On 08/27/2017 10:57 PM, Fam Zheng wrote:
> > On Fri, 08/25 15:44, Max Reitz wrote:
> >> Well, OK.  The main argument against supporting anything but qcow2 is
> >> "if you want features, use qcow2; and we are working on making qcow2 as
> >> fast as possible."  I think that's a very good argument still.  At some
> >> point I (and probably others, too) had the idea of making qcow2 files in
> >> raw layout:
> >
> >
> > Yes! I think this idea makes a whole lot of sense, too. Metadata tables
> can be
> > generated so old implementation can still use it.
> >
> > Fam
> >
> >> Have the data as a blob, just like a raw file, padded by
> >> metadata around it.  An autoclear flag would specify that the qcow2 file
> >> is in this format, and if so, you could simply access it like a raw file
> >> and should have exactly the same speed as a raw file.  Maybe that would
> >> solve this whole issue, too?
>
> I wonder if this would be sufficient to alleviate the desire to use raw
> files...
>
> (Eh, well, realistically, someone's still always going to ask if they
> can use various features with non-qcow2 files...)
>
> Nir, Yaniv; any input?
>

We are using raw format for performance reasons.
As we have many customers that currently use this format, not support it
would be a blocker the use of the feature.
At a minimum we would require ability to convert raw to qcow2 raw-layout.

Please also consider that we are planning to go on the OSP route of LUN per
disk and would still want the tracking to work.
I makes sense that for that and raw format you will be able to save the
mapping to another file other than a qcow.


>
> (Context: We're debating how to add persistent bitmaps to raw files as I
> was informed that RHV was 'asking about it.' Max is reminding me there
> is a proposal for a style of QCOW2 that uses a raw layout for data,
> mitigating or eliminating any performance hits related to the L2 cache.
> What I am not aware of is why RHV would use raw files for any purpose.
> Is it performance? Simplicity? Could RHV use a raw-layout qcow2?)
>
> --js
>
