Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB98D206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZR4Ui48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB98D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic0sG-0001wo-Iq
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 00:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ic0qh-0000nK-U6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ic0qg-0006k2-JJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:35:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33538
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ic0qg-0006iV-CM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575351341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QNIyQn/413RjYVMvKEhOqYOgl4irvtAlaCihJ8k2Bs=;
 b=GZR4Ui486B1yvtodvG1HdtZEuM8uVYMajQVyV99XolXTnr3Hk+9qErYxJ0xsZSwMbbO7UK
 8OyRj8F4O4pQ1MkAjmdBOpAUhZDdm59xVGzC9ZKD1/dIRuzmb96a9yVc27EvkLGLM58aFn
 UIgj+GAqF65zHcnQFClK/N/lseqYN0Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355--eE2MNN0Pb2MlXR63YYJeQ-1; Tue, 03 Dec 2019 00:35:37 -0500
Received: by mail-qt1-f199.google.com with SMTP id k27so1640091qtu.12
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 21:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N5dlmglh+2aq+FuCRC7dXnPfKclYEzf5Fq2o1pMl6YM=;
 b=RzkVlB82WWYIRYmgq7rW8KIAAO0te/RnXcYGaAQZ41byi690cfXdDPqg44fKW3gGvg
 Dau4cKkyRVuGOP2tE9XO6wPfAFgzZn6gwZkGkuObHKxD63f3zu6sqNPgIwV/k+QQgbcO
 6pfFojlW9CGs+7icou8Gk0msmGcpBDsTyHyBadTsZLFzhSF8ctnhmhyz6HgxmS/kuXCX
 OH3ZC5L+ix/ezTdOpMeAQ7qrHbbK2fwhP+RIvksyrePfp4FPXXQfrPlWFSTarPR1ueGy
 od0yH86mz1yTdmYEO2K8aqfRqFAcSBalT9RPldf+UqOa1DKuH+xkYnXDuO/+CFKS+fDo
 KBOw==
X-Gm-Message-State: APjAAAXQHXrpCn7pHjOLzHzAacU+YMTBckxPZigVzvnXXDJYIbzW/4tB
 2z9fEW5nntqQ/pjO7eGbIh164NchfCR8CEi7TAMnA2ywesil0znbxPHNgRQEpE0G9CtWD67gZxZ
 cQ4yjFRLr6wsq9MY=
X-Received: by 2002:a37:6c01:: with SMTP id h1mr3291845qkc.484.1575351337510; 
 Mon, 02 Dec 2019 21:35:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL4+1uCPkvEbGvKGmloEPu0Tu3WhmR4x8HnegZ3h3hQVDbb9HshXoziTN44kTW710y5cXdLA==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr3291826qkc.484.1575351337310; 
 Mon, 02 Dec 2019 21:35:37 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id v31sm1171392qtc.37.2019.12.02.21.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 21:35:36 -0800 (PST)
Date: Tue, 3 Dec 2019 00:35:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v20 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <20191203003445-mutt-send-email-mst@kernel.org>
References: <20191129075634.682-1-tao3.xu@intel.com>
 <a31eeaf7-406f-01c4-5183-cd25835af616@intel.com>
MIME-Version: 1.0
In-Reply-To: <a31eeaf7-406f-01c4-5183-cd25835af616@intel.com>
X-MC-Unique: -eE2MNN0Pb2MlXR63YYJeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "Du, Fan" <fan.du@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sw@weilnetz.de" <sw@weilnetz.de>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 08:53:30AM +0800, Tao Xu wrote:
> Hi Michael,
>=20
> Could this patch series be queued?
> Thank you very much!
>=20
> Tao

QEMU is in freeze, so not yet. Please ping after the release.

--=20
MST


