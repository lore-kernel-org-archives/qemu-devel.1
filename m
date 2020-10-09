Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C77C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16002227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IuNPB9EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16002227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvQZ-0001qL-Qr
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJU-0000T6-Ah
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJS-0005CJ-2u
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id p15so10407033wmi.4
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2mjhIgPQlZZ2dWxmPr6UjFQVI7sVVbQp3ne8yo3G79Y=;
 b=IuNPB9EHkyUKOEPwIxYAh50A0XHxN61a3xMHDbhAX5MIucQ1EW62x1O7147HmboKQJ
 KIHWpVeuYn4AXtVHcLqwsuYtbkNBla8B/avrG9cuwhj4QqSHl4GytX25wS1ep4nrBTTN
 gsu9bMR84Vb1zjQIukdPeZSFgxaob+0/H/B18Ler7UvKd94lcXBVcoI12URIQ94DSPAK
 A4T+vTOjNSX8GlL+ZTsrpHEnQgPNs5kF8ZFVton8W5eoXXLU3hnU+Ldb0pq88qWtxBZl
 mpUw7L6HN3VarZLsCGYsjLBtJEgA3rjmJRDoYngVaYnQreoxFD4x2mVBeOeGMhuG2iTx
 8avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2mjhIgPQlZZ2dWxmPr6UjFQVI7sVVbQp3ne8yo3G79Y=;
 b=tzHR4VhClMSS8cyNkXOmJbEy4ZkQRuGNBC8PfSXTOf/hEKA1LCz/LjDDJzx9j/S7Pz
 CI6um7ZGVhpFM0lvIL5+JHQdW/3CSauFL7b4kKWjuTSTiYzs2BGaupW5xqNGk2hl/LTk
 NMJkiQERCog9kVl2Vv/liLqIySaalZKdzMhq4QnJBeCixThFAsO5sT/VEB9R+gbKbWRf
 4Fome8rCHBYc3vYGNqmn8YsioF+X6Oe//NBhG1pZsrFvNUNPjmNIbTear9BzJhB5Jnl1
 hsHX4ga+0myL/q2i1ixoCI1+hSvzM9q3Hz558fJSgcvChlTg8tFzOCNbMK+7L6qrdvw+
 PVGA==
X-Gm-Message-State: AOAM531PMquxzWUe3CnmUU9E/6MqC8OZ52asBNbTtJkbE3W7jw4NXYlV
 SrZ8PglPqky6EAh3YbXUUHi2SA==
X-Google-Smtp-Source: ABdhPJyJPOUkWmpZTyX++8dNr/EhBuhWLj6ek8tTVjfMyqoKXCJK4qQsldSsn/Fc5So5gzZv6sVEQw==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr15378014wmh.89.1602261128468; 
 Fri, 09 Oct 2020 09:32:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o129sm12855418wmb.25.2020.10.09.09.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:32:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 537C51FF9D;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/22] contrib/gitdm: Add Nir Soffer to Red Hat domain
Date: Fri,  9 Oct 2020 17:31:39 +0100
Message-Id: <20201009163147.28512-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Nir Soffer <nirsof@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Nir Soffer <nirsof@gmail.com>
Message-Id: <20201006160653.2391972-9-f4bug@amsat.org>
Message-Id: <20201007160038.26953-15-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
index d15db2d35e..02507b7b53 100644
--- a/contrib/gitdm/group-map-redhat
+++ b/contrib/gitdm/group-map-redhat
@@ -6,3 +6,4 @@ david@gibson.dropbear.id.au
 laurent@vivier.eu
 pjp@fedoraproject.org
 armbru@pond.sub.org
+nirsof@gmail.com
-- 
2.20.1


