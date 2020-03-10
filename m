Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC9C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B202467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIlQvMEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B202467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbVF-0002WN-A9
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jBbU6-0001bT-On
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jBbU4-0002ap-Dx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:47:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jBbU4-0002YM-AX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583833651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeoBj4R2Cfsk9U2IgIcgkRB20mJrRsqXefgjISX+H0g=;
 b=eIlQvMEKpu5bXwMpOZAJ1rcQe1ORxpKONAWnmii15bEZAzf0nyd5lWECeGxqf7opXqprmu
 /PMPKSaa3olL5MJ5hAJZ+C+umUsIUKPQy/QGP27xdpl/LhwqavNJ+EEyrGQgCYwjaixDg7
 PIpqCzslGgzBKgJ0qIWZuHP+ku55LIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-0kFstVprNl2-LM7uzxcvJQ-1; Tue, 10 Mar 2020 05:47:29 -0400
X-MC-Unique: 0kFstVprNl2-LM7uzxcvJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDCAF8EDBD8;
 Tue, 10 Mar 2020 09:47:28 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE47A5C28D;
 Tue, 10 Mar 2020 09:47:25 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 94E2D3E04B8; Tue, 10 Mar 2020 10:47:23 +0100 (CET)
Date: Tue, 10 Mar 2020 10:47:23 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
Message-ID: <20200310094723.GC22884@paraplu>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com>
 <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:42:25AM -0500, Eric Blake wrote:
> On 3/9/20 10:31 AM, Kashyap Chamarthy wrote:
>=20
> > After (with the patch series applied to QEMU Git):
> >=20
> >      $> git describe
> >      v4.2.0-2204-gd6c7830114
> >=20
> >      # Create; *without* specifying "-F raw"
> >      $> ~/build/qemu/qemu-img create -f qcow2 -b ./base.raw ./overlay2.=
qcow2
> >      qemu-img: warning: Deprecated use of backing file without explicit=
 backing format (detected format of raw)
> >      Formatting './overlay2.qcow2', fmt=3Dqcow2 size=3D4294967296 backi=
ng_file=3D./base.raw backing_fmt=3Draw cluster_size=3D65536 lazy_refcounts=
=3Doff refcount_bits=3D16
>=20
> If you'll note, this case _did_ write an implied backing_fmt=3Draw into t=
he
> image. =20

Ah, I missed to notice that.  Interesting.

> Constrast that with creating an image on a qcow2 backing file, which
> tells you it detected a format of qcow2, but does NOT write
> backing_fmt=3Dqcow2 into the image (this was a change from v2, at Peter's
> request). =20

Indeed, here we go, confirming the overlay of a QCOW2 backing file _not_
having the 'backing_fmt' written into the image:

    $> ~/build/qemu/qemu-img create -f qcow2 -b ./another_base.qcow2 ./over=
lay1_of_ab.qcow2
    qemu-img: warning: Deprecated use of backing file without explicit back=
ing format (detected format of qcow2)
    Formatting './overlay1_of_ab.qcow2', fmt=3Dqcow2 size=3D4294967296 back=
ing_file=3D./another_base.qcow2 cluster_size=3D65536 lazy_refcounts=3Doff r=
efcount_bits=3D16

That's neat.

(I wonder if this bit should also be documented.)

> Thus, when the backing is raw, we warn but future use of the
> image is now safe where it previously was not; when the backing file is
> non-raw, we warn but do not change our behavior, but because the backing
> file is non-raw any future probes will not be any less safe than before.

Understood.  Easy to miss when not paying attention; thanks for pointing
it out.

[...]

> > However, for the "Convert" case, is it correct that no warning is throw=
n
> > for the below?
> >=20
> >      $> ~/build/qemu/qemu-img info overlay1.qcow2
> >      image: overlay1.qcow2
> >      file format: qcow2
> >      virtual size: 4 GiB (4294967296 bytes)
> >      disk size: 196 KiB
> >      cluster_size: 65536
> >      backing file: base.raw
> >      Format specific information:
> >          compat: 1.1
> >          lazy refcounts: false
> >          refcount bits: 16
> >          corrupt: false
>=20
> We have an image with no backing format, so we had to probe.  This patch
> series did not change the behavior of opening an existing image, only for
> creating a new image (or amending an image in-place).  So the lack of a
> warning on opening the unsafe image may be desirable, but it would be via
> even more patches.

Fair enough; it's an understandable compromise.

And your series is a strict improvement as-is; it should not be held up.

>=20
> >      $> ~/build/qemu/qemu-img convert -f qcow2 -O qcow2 overlay1.qcow2 =
flattened.raw
>=20
> Ouch - you are creating a qcow2 destination file named 'flattened.raw',
> which is rather confusing on your part.

Oops, yes it is; bad me.  Sorry for the mix-up.  I meant to amend the
format to 'raw'.

> However, as your destination file is being created without a backing imag=
e,
> it is to be expected that there is no warning (when there is no backing
> file, -F makes no sense). =20

Yeah, fair enough.

> To provoke the warning during convert, you'll
> have to also pass -B (or -o backing_file), without -o backing_fmt (since
> convert lacks the -F shorthand).

Hmm, I tried the following way, but it doesn't provoke the warning:

    $> ~/build/qemu/qemu-img convert -B ./base.raw -O qcow2 overlay1.qcow2 =
flattened.qcow2

    $> ~/build/qemu/qemu-img info flattened.qcow2=20
    image: flattened.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: ./base.raw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false

What am I missing?


            - - -

<digression>

Ah, didn't realize the inconsistency of 'convert' lacking the '-F'
shorthand ... which reminds me, there are at least _three_ ways that I
know of, to specify backing file format with 'create':

    $ qemu-img create -f qcow2 -o 'backing_file=3D./base.raw,backing_fmt=3D=
raw' ./overlay1.qcow2
    $ qemu-img create -f qcow2 -b ./base.raw -o backing_fmt=3Draw overlay1.=
qcow2
    $ qemu-img create -f qcow2 -b ./base.raw -F raw ./overlay1.qcow2

I'm wondering about the consistency of having all the above three
supported for other operations too.  Now I at least know 'convert' lacks
the "-F".

Not sure how much people care about this :-)

</digression>


[...]

--=20
/kashyap


