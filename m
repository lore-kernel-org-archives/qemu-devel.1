Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EA12053B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4PiJQfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVLl-0001an-DJ
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 01:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqVKu-00011Q-US
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:31:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqVKt-0002YD-0t
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593581466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1GunwcsJ5x17bctzwNoWarXwYbAAcW7tbutl7cxIdk=;
 b=Z4PiJQfe1fwV54wyv0hQrF4w/tVMysWXq/RqIRXBlXr9Cr1MPe/hM+cvZfDjTOCH8eZlzJ
 Zn7+fWdijqInmfJGIUaocrisU6m1UExficgJv0CW7BZFZjMvD/2Vxi5EzSpjGTjUjwmWh1
 hKVeUqJsj/o+4XqugQRr+RHTUE+iC0U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-K2gh_eQfOwCdk5OUzqjiXQ-1; Wed, 01 Jul 2020 01:31:04 -0400
X-MC-Unique: K2gh_eQfOwCdk5OUzqjiXQ-1
Received: by mail-pj1-f69.google.com with SMTP id j17so14697477pjy.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 22:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f1GunwcsJ5x17bctzwNoWarXwYbAAcW7tbutl7cxIdk=;
 b=lwYqeDe2+nCkEBcfkzRLXXljzVuSfiEI+S4EOIxU8pcpnceZJE9dpzzEvwHfOhZ9Wk
 yBxiZixloKhmsVgUO/cbFg8m0MWAXyULA4LzBKm383Yz6tPotVK2Laa8FN3Kt5yUFasV
 z+pzoWsFb4414g/vFeX5iqD+oJKvtN4t1+jesYPBKkBvUa+VGRBo0LvxD2ar8DxbSm9u
 bmt/Rp/8VqFjFJu92YPipmmjc0UkPY+e+VyknfO9Ah9hrW8/zD2US3ku3YWLznp//oxl
 tNFrf1OeaFRT3iNIWLNcgMB+RqHqr0Qn3Gqic1L2+lvO0GvEqt5Q18lVtQiCDr4qQxCT
 T9Pw==
X-Gm-Message-State: AOAM533v3c02/rgc2FvGFY+YNqDy+tl6ozfCM0ESL60gJPXTKjDSi0JW
 4r2MKZbKQKD/TEzCY9W3dR10Dw/0bt/uqGH9VN00F6sDvhaw7vOOG50l8eiSBVPt4c3+0J4YPP2
 6KchnQSlkZNXc2LORb2ntPV1pp6Jg3ds=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr18697191pgk.203.1593581463483; 
 Tue, 30 Jun 2020 22:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEORnTy8oAc69k88tmN9pKejyf7acVqrfhvvP/D/J5Z7Z7Qthne2EkT5voe+0gudFqMP8KKlKzsmET0fbrpDY=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr18697151pgk.203.1593581463155; 
 Tue, 30 Jun 2020 22:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <159354041626.15477.8604156689503337818@d1fd068a5071>
 <db885de8-9671-b847-f2f4-b67b245f1c9e@redhat.com>
In-Reply-To: <db885de8-9671-b847-f2f4-b67b245f1c9e@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 1 Jul 2020 13:30:52 +0800
Message-ID: <CACLfguVWuVytBbPTG882OzBmATjA8n-Zn7VCxNNFOZXmruPiwg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] vDPA support in qemu
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Jason, I'm working in this, Will update a new version soon

On Wed, Jul 1, 2020 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/1 =E4=B8=8A=E5=8D=882:06, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200630174937.25560-1-lulu@redha=
t.com/
> >
> >
> >
> > Hi,
> >
> > This series failed the docker-mingw@fedora build test. Please find the =
testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #! /bin/bash
> > export ARCH=3Dx86_64
> > make docker-image-fedora V=3D1 NETWORK=3D1
> > time make docker-test-mingw@fedora J=3D14 NETWORK=3D1
>
>
> Please fix this. You can reproduce this with the above commands.
>
> Thanks
>
>
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> > /tmp/qemu-test/src/hw/net/virtio-net.c:173: undefined reference to `vho=
st_dev_set_config'
> > /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bi=
n/ld: hw/net/virtio-net.o: in function `virtio_net_get_config':
> > /tmp/qemu-test/src/hw/net/virtio-net.c:149: undefined reference to `vho=
st_dev_get_config'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:208: qemu-system-x86_64w.exe] Error 1
> > make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> > make: *** Waiting for unfinished jobs....
> >    LINK    aarch64-softmmu/qemu-system-aarch64w.exe
> > /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bi=
n/ld: hw/net/virtio-net.o: in function `virtio_net_set_config':
> > /tmp/qemu-test/src/hw/net/virtio-net.c:173: undefined reference to `vho=
st_dev_set_config'
> > /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bi=
n/ld: hw/net/virtio-net.o: in function `virtio_net_get_config':
> > /tmp/qemu-test/src/hw/net/virtio-net.c:149: undefined reference to `vho=
st_dev_get_config'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:208: qemu-system-aarch64w.exe] Error 1
> > make: *** [Makefile:527: aarch64-softmmu/all] Error 2
> > Traceback (most recent call last):
> >    File "./tests/docker/docker.py", line 669, in <module>
> >      sys.exit(main())
> > ---
> >      raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',=
 '--label', 'com.qemu.instance.uuid=3D9f5def1ac1a840deb219e8827020f24d', '-=
u', '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET=
_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '=
-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/tmp/ccache',=
 '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '=
/var/tmp/patchew-tester-tmp-lwyumgcs/src/docker-src.2020-06-30-14.01.04.321=
02:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' =
returned non-zero exit status 2.
> > filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D9f5def1ac1a840deb2=
19e8827020f24d
> > make[1]: *** [docker-run] Error 1
> > make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-lwyumgcs/src'
> > make: *** [docker-run-test-mingw@fedora] Error 2
> >
> > real    5m52.723s
> > user    0m8.824s
> >
> >
> > The full log is available at
> > http://patchew.org/logs/20200630174937.25560-1-lulu@redhat.com/testing.=
docker-mingw@fedora/?type=3Dmessage.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
>


