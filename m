Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1BEC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D1A2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxXxd1n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D1A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C5U-0000af-Bt
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6C4R-0008T6-HR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6C4Q-0006Bi-5I
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:38:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6C4Q-0006Bb-1S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582544321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GezWtJiVYxcbr8h8TVEuUpWs+EuuY3CHHGu4eJIIWu0=;
 b=KxXxd1n4EXKr9S6SqIwd2FJzv7KVDPV8r/dKQ7l5UrYU0aax8f8AwmjF0oMpgSxZSB52hC
 /31zOjsO7vqYwJMqapeDNZ4Ng7p0juZ34HjYOzJfhk5hpKxvzj5QM6ZiO0haI/6MKK3WwC
 +H5USz7xoAnOhw+Q/DXL7U2XMtKeV+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-x601qb7aMVK299pJ4ZBDlA-1; Mon, 24 Feb 2020 06:38:37 -0500
X-MC-Unique: x601qb7aMVK299pJ4ZBDlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6664189F760;
 Mon, 24 Feb 2020 11:38:36 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-177.brq.redhat.com [10.40.204.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC93927189;
 Mon, 24 Feb 2020 11:38:31 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:38:27 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] qemu-img: Deprecate use of -b without -F
Message-ID: <20200224113827.GC3296@andariel.pipo.sk>
References: <20200222112341.4170045-1-eblake@redhat.com>
 <20200222112341.4170045-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200222112341.4170045-4-eblake@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 22, 2020 at 05:23:41 -0600, Eric Blake wrote:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot).  If our
> probing algorithm ever changes, or if other tools like libvirt
> determine a different probe result than we do, then subsequent use of
> that backing file under a different format will present corrupted data
> to the guest.  Start a deprecation clock so that future qemu-img can
> refuse to create unsafe backing chains that would rely on probing.
>=20
> However, there is one time where probing is safe: when we first create
> an image, no guest has yet used the new image, so as long as we record
> what we probed, all future uses of the image will see the same data -

I disagree. If you are creating an overlay on top of an existing image
it's not safe to probe the format any more generally. (obviously you'd
have to trust the image and express the trust somehow)

The image may have been used in a VM as raw and that means that the VM
might have recorded a valid qcow2 header into it. Creating the overlay
with probing would legitimize this.

Let's assume we have a malicious image written by the guest but we
simulate it by:

$ qemu-img  create -f qcow2 -F raw -b /etc/passwd /tmp/malicious
Formatting '/tmp/malicious', fmt=3Dqcow2 size=3D2560 backing_file=3D/etc/pa=
sswd backing_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff refcount_b=
its=3D16


Now we want to create an overlay.

a) without this patchset:

$ qemu-img create -f qcow2 -b /tmp/malicious /tmp/pre-patch.qcow2
Formatting '/tmp/pre-patch.qcow2', fmt=3Dqcow2 size=3D2560 backing_file=3D/=
tmp/malicious cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-img info /tmp/pre-patch.qcow2
image: /tmp/pre-patch.qcow2
file format: qcow2
virtual size: 2.5 KiB (2560 bytes)
disk size: 196 KiB
cluster_size: 65536
backing file: /tmp/malicious
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

There's no 'backing file format'. When used by libvirt we'd not allow
the VM to touch the backing file of /tmp/malicious in pre-blockdev era
and in libvirt-6.0 we'd report an error right away.

b) Now with this patchset:

$ ./qemu-img create -f qcow2 -b /tmp/malicious /tmp/post-patch.qcow2
qemu-img: warning: Deprecated use of non-raw backing file without explicit =
backing format, using detected format of qcow2
Formatting '/tmp/post-patch.qcow2', fmt=3Dqcow2 size=3D2560 backing_file=3D=
/tmp/malicious backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=3Dof=
f refcount_bits=3D16
$ qemu-img info /tmp/post-patch.qcow2
image: /tmp/post-patch.qcow2
file format: qcow2
virtual size: 2.5 KiB (2560 bytes)
disk size: 196 KiB
cluster_size: 65536
backing file: /tmp/malicious
backing file format: qcow2
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

You now get a warning, but "backing file format" is now recorded in the
overlay. Now this is WAY worse than it was before. The overlay now
legitimizes the format recorded by the malicious guest which circumvents
libvirt's protections. The warning is very easy to miss, and if you run
it in scripts you might never get to see it. We can't allow that.


> so the code now records the probe results as if the user had passed
> -F.  When this happens, it is unconditionally safe to record a probe
> of 'raw', but any other probe is still worth warning the user in case

While it's safe I don't think it should be encouraged. IMO -F should be
made mandatory with -b.

> our probe differed from their expectations.  Similarly, if the backing
> file name uses the json: psuedo-protocol, the backing name includes
> the format.

Not necessarily. The backing store string can be e.g.:

$ ./qemu-img create -f qcow1 -b 'json:{"driver":"file","filename":"/tmp/mal=
icious"}' /tmp/json.qcow2
Formatting '/tmp/json.qcow1', fmt=3Dqcow2 size=3D197120 backing_file=3Djson=
:{"driver":"file",,"filename":"/tmp/malicious"} cluster_size=3D65536 lazy_r=
efcounts=3Doff refcount_bits=3D16
$ qemu-img info /tmp/json.qcow1
image: /tmp/json.qcow1
file format: qcow1
virtual size: 191 KiB (197120 bytes)
disk size: 195 KiB
cluster_size: 65535
backing file: json:{"driver":"file","filename":"/tmp/malicious"}
Format specific information:
    compat: 0.1
    lazy refcounts: false
    refcount bits: 15
    corrupt: false

Now this has the old semantics but we didn't even get the warning. But
at least the backing file format is not written into the overlay.


> iotest 114 specifically wants to create an unsafe image for later
> amendment rather than defaulting to our new default of recording a
> probed format, so it needs an update.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                    | 17 ++++++++++++++++-
>  qemu-deprecated.texi       | 12 ++++++++++++
>  qemu-img.c                 |  8 +++++++-
>  tests/qemu-iotests/114     |  4 ++--
>  tests/qemu-iotests/114.out |  1 +
>  5 files changed, 38 insertions(+), 4 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 695decbfd7b7..6595683ac52a 100644
> --- a/block.c
> +++ b/block.c
> @@ -6013,6 +6013,15 @@ void bdrv_img_create(const char *filename, const c=
har *fmt,
>                                "Could not open backing image to determine=
 size.\n");
>              goto out;
>          } else {
> +            if (!backing_fmt && !strstart(backing_file, "json:", NULL)) =
{
> +                backing_fmt =3D bs->drv->format_name;
> +                qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, backing_fmt, N=
ULL);

We must never write the detected format into the overlay. Not even when
we print a warning. This can legitimize a malicious file if the user
mises the warning.


