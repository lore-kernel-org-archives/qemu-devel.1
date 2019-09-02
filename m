Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEEC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0648217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acxx0XST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0648217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jV3-0006JS-FJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSo-0004lS-0a
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSk-0004Hq-Jn
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSk-0004HT-DK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id q19so5132547wmc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KLXzyJFC5lUK5mYZENe3rJOMpLSLZyH9F+bD6FR7ECk=;
 b=acxx0XSTbWUBOP46pwFuKAEhPqDkuK0B5utiGh6xZnLC8rzFxhDHTABaPbJOEwq8jY
 6gwJL4riqny7MCvHvY1EoYRSN2ZmUhbnn51LGqoPDv84WmuKde7lcBaoVHmty7BT4qJj
 zkXBNfHM8+SuKqBgLxsElL1xIARvy787E+zYbi3wcEFhOyuZZZDfFcodTn6/GmZkYVan
 tcMTF1dTq6bwMQ2KVzW25WKx3v47cc/KWo/1JQ8Z+kuCXn7/CNe6Lt59mbRBW83Syauq
 267RUMYbBX7YmvQJ+Q3qaBuKEDe69QN2sBDgSH/WVv+P0BI1gi0b0mRBxoI5rxZFbZop
 /vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KLXzyJFC5lUK5mYZENe3rJOMpLSLZyH9F+bD6FR7ECk=;
 b=Ds2YABQiZ+bcinDT+cU7hNM4kJhJRFjs11hHL52HNN0bhQ15y2JTQekwHky1cE8K8S
 fj/7CaTeAw7acm3u78uGv/3PfSt0OtFUD3z9PVP0p3nxRLyutt+XkUSHXD7n1Nn5+zoa
 IO1G5SMvF07mUmUbmbNWrTsZ3BrD2UgaGgdi/CBghKcWfxwP+3udU3qwBL6U0+42RvU3
 pEemvJCe1MgkysYMovn+YBwk14WRqM0s5RKe+Crf5zPj1q2wRbMYjt6SYs8PIBUwE59v
 PIvBFETccmsusC0bf3TIGBtq9OLXXm/CCWCZrubx8Adrt8KoY8yNXLCCq98S7fqnNHzh
 pekQ==
X-Gm-Message-State: APjAAAVSMNC2CiBkl3wXVB3Vo/UtFVNsBeh7wGfm4qCFYuyM5pU9clTI
 WRyLY0Er0bHTaIYQ1ZAbNlSH+A==
X-Google-Smtp-Source: APXvYqx67K4oxfO050PDtvdk9eavyi1LaPhn+/WG4oF1ZN3nJx34qkz9AnO7inRirzs0Fs3I+XQ64g==
X-Received: by 2002:a1c:1acc:: with SMTP id a195mr1279564wma.106.1567419689283; 
 Mon, 02 Sep 2019 03:21:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm18635854wme.27.2019.09.02.03.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC7851FF96;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:17 +0100
Message-Id: <20190902102122.1128-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 07/12] mailmap: Add many entries to improve 'git
 shortlog' statistics
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All of these emails have a least 1 commit with utf8/latin1 encoding
issue, or one with no author name.
When there are multiple commits, keep the author name the most used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190822230916.576-4-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


