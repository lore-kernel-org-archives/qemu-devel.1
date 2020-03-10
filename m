Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C59215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atL8N2Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C59215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgE6-0003GO-IG
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jBgD6-0002Nc-9G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jBgD4-0007Wa-GD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:50:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jBgD4-0007Se-9x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583851817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7SRSq/j68XygfuIv+zmvvyyWwoh8PVoYaF41k5wXeU=;
 b=atL8N2YqVz2zigqhaSiPGKh1kcZ66IiHPGVAlY6MbSqW5K+H4/XtAzYtcLIAiugrTEnZxe
 XkAtjdO1+22WKNnfu/Crp5ISeM/HA8CHprRtP92YfvQXThUh5eh4KezM5ecJW/HSrew2cu
 +lAsRjMF6RSJFP/QlilXcCWTKHAjy/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-oVshHHXLMtSv-16hX8lQSg-1; Tue, 10 Mar 2020 10:50:15 -0400
X-MC-Unique: oVshHHXLMtSv-16hX8lQSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1347800D5E;
 Tue, 10 Mar 2020 14:50:14 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6ADE5D9CA;
 Tue, 10 Mar 2020 14:50:11 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id F15DA3E04B8; Tue, 10 Mar 2020 15:50:09 +0100 (CET)
Date: Tue, 10 Mar 2020 15:50:09 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
Message-ID: <20200310145009.GE22884@paraplu>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com>
 <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
 <20200310105746.GD22884@paraplu>
 <090db695-2281-6704-1d72-4c4c64e3b72a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <090db695-2281-6704-1d72-4c4c64e3b72a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, Mar 10, 2020 at 07:19:25AM -0500, Eric Blake wrote:
> On 3/10/20 5:57 AM, Kashyap Chamarthy wrote:

(Slightly long e-mail, as it contains a bunch of tests and their
results; please bear with me.)

[...]

> >      $> ~/build/qemu/qemu-img amend -o compat=3Dv3 overlay1.qcow2
>=20
> This particular amend is not changing the backing file, and since I did n=
ot
> add warnings on the opening of an existing unsafe image, it is silent.

I see; okay, that's expected.

> Instead, you need to test a case where amend provokes a path that would
> change the backing file (perhaps as simple as '-o backing_file=3D./base.r=
aw'),
> while omitting a format for the new backing file string.

I couldn't work out the black magic to change the backing file via
'qemu-img amend'. =20

It is surely not this:

    $> ~/build/qemu/qemu-img amend -o 'backing_file=3D./bar.qcow2' -o anoth=
er_base.qcow2=20
    qemu-img: Expecting one image file name

Let's try something else: give a *non-existent* "bar.qcow2" to '-o':

    $> ~/build/qemu/qemu-img amend -o 'backing_file=3D./bar.qcow2' another_=
base.qcow2=20
    qemu-img: Could not open 'another_base.qcow2': Could not open backing f=
ile: Failed to get shared "write" lock
    Is another process using the image [./another_base.qcow2]?

That's strange; there is no live QEMU process on this host (let alone
one that is using another_base.qcow2):

    $> pgrep qemu-system-x86
    $> echo $?
    1

Probably it is just complaning about the non-existent bar.qcow2 file?
Then I'd expect it to say as much.


On IRC you pointed out iotest 082 to look for help.  There I don't see a
way to change the backing file.  But only a combination of 'amend' +
'rebase':

    run_qemu_img amend -f $IMGFMT \
        -o backing_fmt=3D$IMGFMT,backing_file=3D"$TEST_IMG",,\? "$TEST_IMG"
    run_qemu_img rebase -u -b "" -f $IMGFMT "$TEST_IMG"

(I know you can use 'rebase' alone to change the backing file format.)

Note to self: we really need to document 'amend' much better, in which
scenarios it is useful, and contrast it with 'rebase'.

            - - -

Meanwhile, I've done a bunch of tests with 'amend'.  Here are the
results.

Scenario: base.raw <-- overlay1.qcow2
-------------------------------------

Without "-f raw", the warning is provoked when trying to amend the
backing file (let's ignore for a moment that you can't seem to amend a
raw file):

    $> ~/build/qemu/qemu-img amend -o compat=3Dv3 base.raw
    WARNING: Image format was not specified for 'base.raw' and probing gues=
sed raw.
             Automatically detecting the format is dangerous for raw images=
, write operations on block 0 will be restricted.
             Specify the 'raw' format explicitly to remove the restrictions=
.
    qemu-img: Format driver 'raw' does not support option amendment

With "-f raw", the warning is not triggerred (correctly so?):

    $> ~/build/qemu/qemu-img amend -o compat=3Dv3 -f raw base.raw
    qemu-img: Format driver 'raw' does not support option amendment


And these two tests (one with relative path; the other with absolute
path) don't trigger the warning either (on IRC you said the following is
_supposed_ to trigger a warning):


    $> ~/build/qemu/qemu-img amend \
            -o 'backing_file=3Dbase.raw' -f qcow2 overlay1.qcow2

    $> ~/build/qemu/qemu-img amend \
            -o 'backing_file=3D./base.raw' -f qcow2 overlay1.qcow2


'qemu-img info' of the above disk image chain:

    $> ~/build/qemu/qemu-img info --backing-chain overlay1.qcow2
    image: overlay1.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: ./base.raw
    backing file format: raw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false
   =20
    image: ./base.raw
    file format: raw
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 778 MiB


Scenario: another_base.qcow2 <-- overlay1_of_ab.qcow2
-----------------------------------------------------

With and w/o specifying the aAmend the backing file (none of these
provoke the warning -- expected?):

    $> ~/build/qemu/qemu-img amend another_base.qcow2

    $> ~/build/qemu/qemu-img amend -f qcow2 another_base.qcow2

Tests to amend the overlay file (none of these provoke the warning --
expected, per your previous reply):

    $> ~/build/qemu/qemu-img amend overlay1_of_ab.qcow2 =20

    $> ~/build/qemu/qemu-img amend -f qcow2 overlay1_of_ab.qcow2 =20


'qemu-img info' of the above disk image chain:

    $> ~/build/qemu/qemu-img info --backing-chain overlay1_of_ab.qcow2=20
    image: overlay1_of_ab.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: ./another_base.qcow2
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false
   =20
    image: ./another_base.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 293 MiB
    cluster_size: 65536
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false


Strange command-line
--------------------

Does this make sense?  What is this even trying to do ...

    $> ~/build/qemu/qemu-img amend \
            -o 'backing_file=3D./another_base.qcow2' another_base.qcow2=20
   =20
    $> echo $?
    0

> Look at patch 2/4 - that patch was written AFTER this patch in order to
> silence every warning that was introduced because of this patch, then
> rebased to occur first.  My experience in writing 2/4 was that I indeed h=
it
> warnings through all four sub-commands.=20

Will look.

Thanks.

--=20
/kashyap


