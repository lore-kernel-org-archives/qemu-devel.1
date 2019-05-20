Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9154C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0D521479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdBkLMoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0D521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSpuc-0000d5-Rn
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:33:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hSptf-0000K1-06
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hSptd-0000jw-Uh
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:32:38 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hSptd-0000iY-Nx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:32:37 -0400
Received: by mail-ed1-x541.google.com with SMTP id a8so25978308edx.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=u6k4hBUKXhBkhz0eJFcBXEVgCfkiPe44R89+1jjTNmE=;
	b=DdBkLMozmIYTeFNqq5xcTzIRj2KO5Jb08bVyIUkeR5rpIlfir1VpLzWgpd0LyW2jms
	5PIFyNDYa4ZHMy1/FckPhM10UWLznVsbq4tZt+gS3uFVp3YWxHaqlxsgDmwK6s3c2biC
	RGvmeiVfLrkI1fMZqUpwY4/v+U1bHJT2DNzsicsn18un+w/GwIA2UKxxM9OyPJ+Y055+
	us2eL418dYleJP8ZPJ0kNQ40bkWKYlYFIh8w6fN6z1j88KZ0ZIJvcG5mHLK+7wy5VQjc
	sEX1HKFZhi/0s/wVBE+2x8tj+GpCgZHO/c//on03tYh2sfKrt7lJfLI8fpcH/ZzLe3w9
	0KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=u6k4hBUKXhBkhz0eJFcBXEVgCfkiPe44R89+1jjTNmE=;
	b=objKSs+2uiiPLLPp1+GjnX4I3Y3r5i7JVkgq6vHsDopZIgLXf50VmCbgeZ5pCVD02Y
	DKhQPqehDSdRi3MaCK3eZpZbpw67MPYuvdS+qgfNvDmEwqMrW5q0H6RpKwtLFGqOOAVs
	/Z0fAEjRQDTinhUgYU5RZVNhYuVNA/RY8+zyefViXr2yxp49jKuq1jFCKHIETv9FZuIt
	HBqB3CMR4BtQM4cakla6BxbzY3jnVZiq8ZQrj39y361eemm5Yj2jaTbckIzuJfgMBubH
	qt43FTUcWaMti8e/mV0F2YOnLhUbjm5USO9L5oGSTUdpjt292uvKUhWa4Ux67Nu7oJzN
	nrvw==
X-Gm-Message-State: APjAAAV2N/NbfWilv4+daBABDqKTTxD8Q+gluShI1wVYS2mWK3a7PqVJ
	QUQBMJj0M5XSV//U3TMnAiY=
X-Google-Smtp-Source: APXvYqyKp/hzA81YFYJLzeLoD66+naXVMrnKnyNTomtZfqdB8uIAZhxNWrZJt1bCAJjrs0U67sVkEQ==
X-Received: by 2002:a17:906:488e:: with SMTP id
	v14mr21507857ejq.216.1558387955855; 
	Mon, 20 May 2019 14:32:35 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	q11sm5904346edd.51.2019.05.20.14.32.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 14:32:34 -0700 (PDT)
Date: Mon, 20 May 2019 21:32:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190520213233.6px3cuws2hq3p5tj@master>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-6-quintela@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 5/8] migration: Add multifd-compress
 parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:15:41PM +0200, Juan Quintela wrote:
>diff --git a/qapi/migration.json b/qapi/migration.json
>index 9cfbaf8c6c..8ec1944b7a 100644
>--- a/qapi/migration.json
>+++ b/qapi/migration.json
>@@ -482,6 +482,19 @@
> ##
> { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
> 
>+##
>+# @MultifdCompress:
>+#
>+# An enumeration of multifd compression.
>+#
>+# @none: no compression.
>+#
>+# Since: 4.1
>+#
>+##
>+{ 'enum': 'MultifdCompress',
>+  'data': [ 'none' ] }
>+
> ##
> # @MigrationParameter:
> #
>@@ -580,6 +593,9 @@
> # @max-cpu-throttle: maximum cpu throttle percentage.
> #                    Defaults to 99. (Since 3.1)
> #
>+# @multifd-compress: Which compression method to use.
>+#                    Defaults to none. (Since 4.1)
>+#
> # Since: 2.4
> ##
> { 'enum': 'MigrationParameter',
>@@ -592,7 +608,7 @@
>            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>            'multifd-channels',
>            'xbzrle-cache-size', 'max-postcopy-bandwidth',
>-           'max-cpu-throttle' ] }
>+           'max-cpu-throttle', 'multifd-compress' ] }
> 
> ##
> # @MigrateSetParameters:
>@@ -682,6 +698,9 @@
> # @max-cpu-throttle: maximum cpu throttle percentage.
> #                    The default value is 99. (Since 3.1)
> #
>+# @multifd-compress: Which compression method to use.
>+#                    Defaults to none. (Since 4.1)
>+#
> # Since: 2.4
> ##
> # TODO either fuse back into MigrationParameters, or make
>@@ -707,7 +726,8 @@
>             '*multifd-channels': 'int',
>             '*xbzrle-cache-size': 'size',
>             '*max-postcopy-bandwidth': 'size',
>-	    '*max-cpu-throttle': 'int' } }
>+	    '*max-cpu-throttle': 'int',

A tab at the beginning, it would be better to fix this :-)

>+            '*multifd-compress': 'MultifdCompress' } }
> 
> ##
> # @migrate-set-parameters:
>@@ -817,6 +837,9 @@
> #                    Defaults to 99.
> #                     (Since 3.1)
> #
>+# @multifd-compress: Which compression method to use.
>+#                    Defaults to none. (Since 4.1)
>+#
> # Since: 2.4
> ##
> { 'struct': 'MigrationParameters',
>@@ -840,7 +863,8 @@
>             '*multifd-channels': 'uint8',
>             '*xbzrle-cache-size': 'size',
> 	    '*max-postcopy-bandwidth': 'size',
>-            '*max-cpu-throttle':'uint8'} }
>+            '*max-cpu-throttle': 'uint8',
>+            '*multifd-compress': 'MultifdCompress' } }
> 
> ##
> # @query-migrate-parameters:

-- 
Wei Yang
Help you, Help me

