Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D79C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541152225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVTGfNNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541152225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvsJ-0004HV-Fu
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRF-000371-HY
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRD-0006Hm-TZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id n18so10969415wrs.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KDLLYMFneKPqV8ITU48ica/gOmqj87zpo4SyEfB4DLU=;
 b=aVTGfNNWc2ObbLzDmCzy1vBROcuaOtjNCW62aGjbLKQlp7tXPIN3OVPjKRw8ULKAI5
 7JKodz36GMPf5k7Fj4z7dyEAp2zKhvHM4VMFohaYaHoMAlFBSJKhKcPkylGKBH3P8J6W
 Chj7n0tOmHxDYG/49o+j2PlOeJePIYwQPozRuoZNImxOXzO5U2ETcEBN8cskMop+KxQH
 UDa3qUvoXu457OdXC5ptmgdFnq6sT8dKUhgBuWfN4gkYbP9313vwiKMpU9LfdPBOdTw/
 9kDH0nD+OzUmgrh8+mo3ELdQAZbfVbYcE/lc1SC0vhHh0Hrt2hPniU1LgI979N7wlH5r
 qVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KDLLYMFneKPqV8ITU48ica/gOmqj87zpo4SyEfB4DLU=;
 b=c++HpKcYLkxtM6EZhCojJedadhjm+3CAG/+dScQXExKvfDzxQzWC0n/6+vccYeoDyk
 G/BFGeLKlMQvfEs0j0C2wLi3mzV1EFBnBVmzF/cdpSdp4yBR54ypR5geaY//FVtJv/S1
 HAdIQRUgxm1ZDq6Z0mkS/D6pOpIO5KIzygWUY2vIfOWzMEdMoiUzGWUNVPtf03k1Fl0N
 i0YbmrXW8iiNAIgZ4jF3L726dx6Esn609zr0B1KD1l54Pgcr+DN5dfm68u6iFzSZssF9
 q5Y6H5ap2Pg/oqg0g6TIAj1Hr5egja6FxPEvTmd+6iXlZS8+kGr61apEhtel20B3/ET9
 xOLg==
X-Gm-Message-State: AOAM530G45fJbpTzO72XhDwqPKIOVhCC4BjXfnWCxcsMONgu7KOYQgGn
 V4JDfwx31uGgrKAd/Jkbpn+rrQ==
X-Google-Smtp-Source: ABdhPJyxbWLEjpOdd/cXt92jDhHXHFXHgl36KU7fFVodfcFL1AeV27KuqXOM6SmZUn5OluTD+shN8w==
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr60808wrp.319.1602261609627;
 Fri, 09 Oct 2020 09:40:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f63sm12877130wme.38.2020.10.09.09.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE0021FFA6;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/22] .mailmap: Fix more contributor entries
Date: Fri,  9 Oct 2020 17:31:43 +0100
Message-Id: <20201009163147.28512-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Erik Smit <erik.lucas.smit@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

These authors have some incorrect author email field.
For each of them, there is one commit with the replaced
entry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Erik Smit <erik.lucas.smit@gmail.com>
Message-Id: <20201006160653.2391972-13-f4bug@amsat.org>
Message-Id: <20201007160038.26953-19-alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index b914c9e290..663819fb01 100644
--- a/.mailmap
+++ b/.mailmap
@@ -85,6 +85,7 @@ Christophe Lyon <christophe.lyon@st.com>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
 Eduardo Otubo <otubo@redhat.com>
+Erik Smit <erik.lucas.smit@gmail.com>
 Fabrice Desclaux <fabrice.desclaux@cea.fr>
 Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
 Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp>
@@ -142,6 +143,7 @@ Roger Pau Monné <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
 Sochin Jiang <sochin.jiang@huawei.com>
+Stefan Berger <stefanb@linux.vnet.ibm.com> <stefanb@linux.ibm.com>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
-- 
2.20.1


