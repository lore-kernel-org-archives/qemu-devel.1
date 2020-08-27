Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF271C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FCC20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCC20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBC07-0004kU-1j
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kBBzY-0004Ks-Cv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:06:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4656 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kBBzW-0003KZ-IX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:06:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A5DFD7A2C7C666F173D5;
 Thu, 27 Aug 2020 15:06:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.46) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 15:06:13 +0800
Subject: Re: [PATCH 06/12] ui/gtk-gl-area: Plug memleak in
 gd_gl_area_create_context()
To: Li Qiang <liq3ea@gmail.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-7-pannengyuan@huawei.com>
 <CAKXe6SJ-=AbZMQ+8snQcPjnZ-r-2+FSHVCVkA2tkba6ujpJCbg@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <0f8c0192-da25-d5a9-dd9e-2ef72f3f8a6c@huawei.com>
Date: Thu, 27 Aug 2020 15:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJ-=AbZMQ+8snQcPjnZ-r-2+FSHVCVkA2tkba6ujpJCbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.46]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:12:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 20:20, Li Qiang wrote:
> Pan Nengyuan <pannengyuan@huawei.com> 于2020年8月14日周五 下午6:15写道：
>>
>> Receiving error in local variable err, and forgot to free it.
>> Considering that there is no place to deal with it. Clean up.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  ui/gtk-gl-area.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>> index 85f9d14c51..c740a7eb14 100644
>> --- a/ui/gtk-gl-area.c
>> +++ b/ui/gtk-gl-area.c
>> @@ -142,15 +142,14 @@ QEMUGLContext gd_gl_area_create_context(DisplayChangeListener *dcl,
>>      VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>>      GdkWindow *window;
>>      GdkGLContext *ctx;
>> -    GError *err = NULL;
>>
>>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>>      window = gtk_widget_get_window(vc->gfx.drawing_area);
>> -    ctx = gdk_window_create_gl_context(window, &err);
>> +    ctx = gdk_window_create_gl_context(window, NULL);
>>      gdk_gl_context_set_required_version(ctx,
>>                                          params->major_ver,
>>                                          params->minor_ver);
>> -    gdk_gl_context_realize(ctx, &err);
>> +    gdk_gl_context_realize(ctx, NULL);
>>      return ctx;
>>  }
> 
> Maybe we should check the return value of  'gdk_window_create_gl_context'
> and 'gdk_gl_context_realize' instead of omitting it?

OK, Agree with you.

How about check the value like the below?
(Return NULL when error happens in gdk_gl_context_realize. It's different from the original.)

Thanks.

--------
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 85f9d14c51..98c22d23f5 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -147,10 +147,21 @@ QEMUGLContext gd_gl_area_create_context(DisplayChangeListener *dcl,
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     ctx = gdk_window_create_gl_context(window, &err);
+    if (err) {
+        g_printerr("Create gdk gl context failed: %s\n", err->message);
+        g_error_free(err);
+        return NULL;
+    }
     gdk_gl_context_set_required_version(ctx,
                                         params->major_ver,
                                         params->minor_ver);
     gdk_gl_context_realize(ctx, &err);
+    if (err) {
+        g_printerr("Realize gdk gl context failed: %s\n", err->message);
+        g_error_free(err);
+        g_clear_object(&ctx);
+        return NULL;
+    }
     return ctx;
 }


> 
> Thanks,
> Li Qiang
> 
>>
> 
>> --
>> 2.18.2
>>
>>
> .
> 


