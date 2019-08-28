Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871ADC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5288F20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hbnd16bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5288F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wx0-0001ut-Az
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wkp-0001Uw-0y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wki-000426-EM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wki-00041j-7D
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id q12so2218527wrj.12
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WhFgRoPVxQ8mAs57TpcZgKKhgcw7NpZ+wstXmg9Dw5M=;
 b=Hbnd16bNIyGpSXjf7U4OCzf8zpH17axi2C6AVmSAjLdf+0iMutXxKvesUO5R5TUR1H
 nydmon4zOctkDgChsKEjkljhgpnzzMmiN8cXnZXMYsxiYhRn/jiIsOyGIN4tVy7Nc3og
 IsVs4/24MmZOGv6lWf9uwBzQGSMIDJPrUt3rJY67Ux8uXqBxMYIStA5kww5IeQCy0UY6
 gjH+DFayXfB19xpHGDa1ju2N9zxqHqCy6d9OUgPqGdWNNILEA4r90plMVhrboC568TpE
 CEfdIZp6SCcdGoFzmNct/7TtcbtzIX+rWbkIdKCWK2LJEi3ita3QZsUQAHIEZiHhVY9i
 /uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WhFgRoPVxQ8mAs57TpcZgKKhgcw7NpZ+wstXmg9Dw5M=;
 b=KgXVitFMG/e57lrpoRaI4vXL+Svx7+EJMfZKgCEvjBslEuKauWyhwisrlYsjY742VN
 O+6TbSxvGFmTqJ/t8XPcNM+k3OQg7wl0/CMNEvYkapdB1FAAWK1EZMfmGLMzMnyhlkqD
 aCAAVOTJqkTwqDhz14e9nYr1PDZAH5McVr8nHq1GdoJQ7SgeFAB1cbUpLU1mo+KizV+u
 QJgjJIyRHNpuCnj2Q03K/4vIOWhOuKDU7GBSWcJ+Rnr+ayl0DbgbTvVyhaSaXwIrsaIU
 o2c6/UW/hbbe8xF6ntTLi3jztTlY2/Eh/G85bfbVMLv/v5LdpY7klzSZw4oufVTM4Hb4
 dTzg==
X-Gm-Message-State: APjAAAX7FUdwpP+9Dye9CXNY2nXt4aPSbEK6ZYIDKjE5c49LjpIv1v/K
 RSqbnWB7vNHcUlEC4vSF+SoYWQNXuPM=
X-Google-Smtp-Source: APXvYqwThTIJJLqNoudpA4oiEpua2ExSm8AWKpTMJv5Jw5zNVHK3nhsoROSNCIo2Cl4gurDfbxOoIA==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr4587881wrq.63.1566994118847;
 Wed, 28 Aug 2019 05:08:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm2305807wrn.41.2019.08.28.05.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:08:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E1C471FF92;
 Wed, 28 Aug 2019 13:08:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:08:29 +0100
Message-Id: <20190828120832.9208-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120832.9208-1-alex.bennee@linaro.org>
References: <20190828120832.9208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 5/8] mailmap: Add many entries to improve
 'git shortlog' statistics
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All of these emails have a least 1 commit with utf8/latin1 encoding
issue, or one with no author name.
When there are multiple commits, keep the author name the most used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190822230916.576-4-philmd@redhat.com>
---
 .mailmap | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/.mailmap b/.mailmap
index e68ddd26e67..d0fc1d793c6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -37,5 +37,110 @@ Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
+Aaron Lindsay <aaron@os.amperecomputing.com>
+Alexey Gerasimenko <x1917x@gmail.com>
+Alex Ivanov <void@aleksoft.net>
+Andreas Färber <afaerber@suse.de>
+Bandan Das <bsd@redhat.com>
+Benjamin MARSILI <mlspirat42@gmail.com>
+Benoît Canet <benoit.canet@gmail.com>
+Benoît Canet <benoit.canet@irqsave.net>
+Benoît Canet <benoit.canet@nodalink.com>
+Boqun Feng <boqun.feng@gmail.com>
+Boqun Feng <boqun.feng@intel.com>
+Brad Smith <brad@comstyle.com>
+Brijesh Singh <brijesh.singh@amd.com>
+Brilly Wu <brillywu@viatech.com.cn>
+Cédric Vincent <cedric.vincent@st.com>
+CheneyLin <linzc@zju.edu.cn>
+Chen Gang <chengang@emindsoft.com.cn>
+Chen Gang <gang.chen.5i5j@gmail.com>
+Chen Gang <gang.chen@sunrus.com.cn>
+Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
+Christophe Lyon <christophe.lyon@st.com>
+Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
+Eduardo Otubo <otubo@redhat.com>
+Fabrice Desclaux <fabrice.desclaux@cea.fr>
+Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
+Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp>
+Gautham R. Shenoy <ego@in.ibm.com>
+Gautham R. Shenoy <ego@linux.vnet.ibm.com>
+Gonglei (Arei) <arei.gonglei@huawei.com>
+Guang Wang <wang.guang55@zte.com.cn>
+Hailiang Zhang <zhang.zhanghailiang@huawei.com>
+Hervé Poussineau <hpoussin@reactos.org>
+Jakub Jermář <jakub@jermar.eu>
+Jakub Jermář <jakub.jermar@kernkonzept.com>
+Jean-Christophe Dubois <jcd@tribudubois.net>
+Jindřich Makovička <makovick@gmail.com>
+John Arbuckle <programmingkidx@gmail.com>
+Juha Riihimäki <juha.riihimaki@nokia.com>
+Juha Riihimäki <Juha.Riihimaki@nokia.com>
+Jun Li <junmuzi@gmail.com>
+Laurent Vivier <Laurent@lvivier.info>
+Leandro Lupori <leandro.lupori@gmail.com>
+Li Guang <lig.fnst@cn.fujitsu.com>
+Liming Wang <walimisdev@gmail.com>
+linzhecheng <linzc@zju.edu.cn>
+Liran Schour <lirans@il.ibm.com>
+Liu Yu <yu.liu@freescale.com>
+Liu Yu <Yu.Liu@freescale.com>
+Li Zhang <zhlcindy@gmail.com>
+Li Zhang <zhlcindy@linux.vnet.ibm.com>
+Lluís Vilanova <vilanova@ac.upc.edu>
+Lluís Vilanova <xscript@gmx.net>
+Longpeng (Mike) <longpeng2@huawei.com>
+Luc Michel <luc.michel@git.antfield.fr>
+Luc Michel <luc.michel@greensocs.com>
+Marc Marí <marc.mari.barcelo@gmail.com>
+Marc Marí <markmb@redhat.com>
+Michael Avdienko <whitearchey@gmail.com>
+Michael S. Tsirkin <mst@redhat.com>
+Munkyu Im <munkyu.im@samsung.com>
+Nicholas Bellinger <nab@linux-iscsi.org>
+Nicholas Thomas <nick@bytemark.co.uk>
+Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
+Orit Wasserman <owasserm@redhat.com>
+Paolo Bonzini <pbonzini@redhat.com>
+Pavel Dovgaluk <dovgaluk@ispras.ru>
+Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
+Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
+Peter Crosthwaite <crosthwaite.peter@gmail.com>
+Peter Crosthwaite <peter.crosthwaite@petalogix.com>
+Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+Prasad J Pandit <pjp@fedoraproject.org>
+Prasad J Pandit <ppandit@redhat.com>
+Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
 Reimar Döffinger <Reimar.Doeffinger@gmx.de>
+Remy Noel <remy.noel@blade-group.com>
+Roger Pau Monné <roger.pau@citrix.com>
+Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
+Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
+Sochin Jiang <sochin.jiang@huawei.com>
+Takashi Yoshii <takasi-y@ops.dti.ne.jp>
+Thomas Huth <thuth@redhat.com>
+Thomas Knych <thomaswk@google.com>
+Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
+Tony Nguyen <tony.nguyen@bt.com>
+Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>
+Vibi Sreenivasan <vibi_sreenivasan@cms.com>
+Vijaya Kumar K <vijayak@cavium.com>
+Vijaya Kumar K <Vijaya.Kumar@cavium.com>
+Vijay Kumar <vijaykumar@bravegnu.org>
+Vijay Kumar <vijaykumar@zilogic.com>
+Wang Guang <wang.guang55@zte.com.cn>
+Wenchao Xia <xiawenc@linux.vnet.ibm.com>
+Wenshuang Ma <kevinnma@tencent.com>
+Xiaoqiang Zhao <zxq_yx_007@163.com>
+Xinhua Cao <caoxinhua@huawei.com>
+Xiong Zhang <xiong.y.zhang@intel.com>
+Yin Yin <yin.yin@cs2c.com.cn>
+yuchenlin <npes87184@gmail.com>
+YunQiang Su <syq@debian.org>
+YunQiang Su <ysu@wavecomp.com>
+Yuri Pudgorodskiy <yur@virtuozzo.com>
+Zhengui Li <lizhengui@huawei.com>
+Zhenwei Pi <pizhenwei@bytedance.com>
+Zhenwei Pi <zhenwei.pi@youruncloud.com>
+Zhuang Yanying <ann.zhuangyanying@huawei.com>
-- 
2.20.1


