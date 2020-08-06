Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D22204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIdReF5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D22204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cxb-0005QC-61
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k3cwS-0004wq-RX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:16:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k3cwQ-0003qX-Vw
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596708964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFKrUjjkOFZiBV5Z+F6A64nK9xVU4UrzxL3BD+g+SMc=;
 b=SIdReF5B79TCw2ToWNic26urylYmw5DrPHcFSocGDzkybk3E4I5xsDegPqJbaGSMOsNQ59
 lGfrqHJOUu2gpVL+HMsYiTGAbVzz60yvsmeSgzaewMSF6/oQrBC5VuorMAd+kTgObkvP+e
 Iv9FCf424n7FEPUWYKsRqGRzd+uouKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-hbFX-Tk_NWGEcwLCh8vnRQ-1; Thu, 06 Aug 2020 06:14:55 -0400
X-MC-Unique: hbFX-Tk_NWGEcwLCh8vnRQ-1
Received: by mail-wr1-f72.google.com with SMTP id b13so11857016wrq.19
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=tjhzc3DZAJOCSB2tramfpoH4PDygFrsd3e9qQTU8hrA=;
 b=Tf7iBgGJHpADIQuxenoZICUHsVvolxzc1lSM4/Ih1FSk9+3Bq/GvfTMzTKoeKDqNbF
 63UeuveTbyHczwUYAXNb0Z0fw12gHE8ZVihQIXduzKD9A8Yv62WCvJAFqVz6knnQAi0k
 httEQIUdIVqayrt17TIhaSHEgxy61IBLp7ROQMHxqII16H+zBCnTbD/kkE4Z4WM5whx+
 BnaTe4r3+l3liDIOAoUn3G+50aj5di8o6EerVRS0NeG4H3rzNTqhgkOsgT+V0EZTJaVJ
 oTCVOKG+G7VRLoJGDUsqIT+QfqxTGt7OUwRMK2luK9Fn1yazPAiRek5Ik7PSmPfLFdCk
 id2g==
X-Gm-Message-State: AOAM533BhE31Y81NnoIRZPcJF+/4UIhkT4tXCLFhLWEpCLvqVwdO7w6N
 pVd8hLnc6zkkfm06wRZ7IQcJiu7ztF1FtT+ot4JtruX6pj3sRpjQ3cAEGL2BPaYo2ihEt6FJOmw
 EDtOpDNhIYd3rv2I=
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr6582896wrp.355.1596708894551; 
 Thu, 06 Aug 2020 03:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpZDbLTvTkdUsFaVMxY0730u1E4zKAWjthEP+hX2v8qGoILa86CNX31m7CqvUJ2m0JfUnkpA==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr6582877wrp.355.1596708894241; 
 Thu, 06 Aug 2020 03:14:54 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:d0c5:70f6:7493:1710?
 ([2a01:e0a:466:71c0:d0c5:70f6:7493:1710])
 by smtp.gmail.com with ESMTPSA id x82sm6049798wmb.30.2020.08.06.03.14.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Aug 2020 03:14:53 -0700 (PDT)
From: Christophe de Dinechin <dinechin@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Qemu web site down?
Message-Id: <9C8E7160-7A4D-4002-8DE8-6BBFE0C2240A@redhat.com>
Date: Thu, 6 Aug 2020 12:14:51 +0200
To: Stefan Weil <sw@weilnetz.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,


The link from https://wiki.qemu.org/Documentation pointing to https://qemu.=
weilnetz.de/doc/qemu-doc.html seems to be dead. Is the problem on your web =
site, or should the wiki be updated?


Thanks
Christophe


