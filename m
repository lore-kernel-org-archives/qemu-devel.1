Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB651C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 09:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8E820872
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 09:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="b4xW2WaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8E820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbKzm-0007P4-8B
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 04:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kbKzC-0006xd-GM
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 04:58:18 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:40049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kbKzA-0001NT-IP
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 04:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=HQhlzxGZmZEPN3cVjsuMRIkse22+wlWlgU2NgU5MLsM=; b=b4xW2WaQTdUDY8m7JYqX9p2wrw
 8r/5ko+Nr2pnsrUZpfpaDtcuwmlCO8qw0s8C9HjVnrRkyy1cNFVqeQ9QAUKiA9Wle46Uqe5hfctid
 s3aKq6z33xB7GzwFUpFO8pqW+pxJ4OKLwCNwmWQlm9qhzE/iQHEiRICNDI13bgtk0gXYXXACltFO7
 zVr5Zw46zixUgakWHLjEePWYkw9tmxMHWp1Q0DDnYwzsNXHBvIm1gEBoQMkFJC9GXWOgBgYgBmD+R
 mZsWIKrZ2dG8dX+x4AUqptO1TLp/xB8tPrjQKkYr0Zr9DYPRxp8QftMlkEF+bU+J2vZ7mwoamuUJ8
 hncmCv6g==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v9 1/1] audio/jack: fix use after free segfault
Date: Sat, 07 Nov 2020 10:58:10 +0100
Message-ID: <15581795.ItcsEykuCY@silver>
In-Reply-To: <20201107000458.8754-2-geoff@hostfission.com>
References: <20200821134554.101397-2-geoff@hostfission.com>
 <20201107000458.8754-1-geoff@hostfission.com>
 <20201107000458.8754-2-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 04:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 7. November 2020 01:04:58 CET Geoffrey McRae wrote:
> This change registers a bottom handler to close the JACK client
> connection when a server shutdown signal is recieved. Without this
> libjack2 attempts to "clean up" old clients and causes a use after free
> segfault.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  audio/jackaudio.c | 50 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 1e714b30bc..e00e19061a 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "qemu/atomic.h"
> +#include "qemu/main-loop.h"
>  #include "qemu-common.h"
>  #include "audio.h"
> 
> @@ -63,6 +64,7 @@ typedef struct QJackClient {
>      QJackState      state;
>      jack_client_t  *client;
>      jack_nframes_t  freq;
> +    QEMUBH         *shutdown_bh;
> 
>      struct QJack   *j;
>      int             nchannels;
> @@ -87,6 +89,7 @@ QJackIn;
>  static int qjack_client_init(QJackClient *c);
>  static void qjack_client_connect_ports(QJackClient *c);
>  static void qjack_client_fini(QJackClient *c);
> +QemuMutex qjack_shutdown_lock;
> 

I think this should be:

static QemuMutex qjack_shutdown_lock;

as this mutex is only accessed from within this unit. Except of that:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

BTW it is common practice to add local functions for initializing, destroying, 
locking and unlocking a specific mutex use case to avoid issues when code 
evolves. But so far the use of this mutex is trivial, so it is Ok for now from 
my PoV.

>  static void qjack_buffer_create(QJackBuffer *buffer, int channels, int
> frames) {
> @@ -306,21 +309,27 @@ static int qjack_xrun(void *arg)
>      return 0;
>  }
> 
> +static void qjack_shutdown_bh(void *opaque)
> +{
> +    QJackClient *c = (QJackClient *)opaque;
> +    qjack_client_fini(c);
> +}
> +
>  static void qjack_shutdown(void *arg)
>  {
>      QJackClient *c = (QJackClient *)arg;
>      c->state = QJACK_STATE_SHUTDOWN;
> +    qemu_bh_schedule(c->shutdown_bh);
>  }
> 
>  static void qjack_client_recover(QJackClient *c)
>  {
> -    if (c->state == QJACK_STATE_SHUTDOWN) {
> -        qjack_client_fini(c);
> +    if (c->state != QJACK_STATE_DISCONNECTED) {
> +        return;
>      }
> 
>      /* packets is used simply to throttle this */
> -    if (c->state == QJACK_STATE_DISCONNECTED &&
> -        c->packets % 100 == 0) {
> +    if (c->packets % 100 == 0) {
> 
>          /* if enabled then attempt to recover */
>          if (c->enabled) {
> @@ -489,15 +498,16 @@ static int qjack_init_out(HWVoiceOut *hw, struct
> audsettings *as, QJackOut *jo  = (QJackOut *)hw;
>      Audiodev *dev = (Audiodev *)drv_opaque;
> 
> -    qjack_client_fini(&jo->c);
> -
>      jo->c.out       = true;
>      jo->c.enabled   = false;
>      jo->c.nchannels = as->nchannels;
>      jo->c.opt       = dev->u.jack.out;
> 
> +    jo->c.shutdown_bh = qemu_bh_new(qjack_shutdown_bh, &jo->c);
> +
>      int ret = qjack_client_init(&jo->c);
>      if (ret != 0) {
> +        qemu_bh_delete(jo->c.shutdown_bh);
>          return ret;
>      }
> 
> @@ -525,15 +535,16 @@ static int qjack_init_in(HWVoiceIn *hw, struct
> audsettings *as, QJackIn  *ji  = (QJackIn *)hw;
>      Audiodev *dev = (Audiodev *)drv_opaque;
> 
> -    qjack_client_fini(&ji->c);
> -
>      ji->c.out       = false;
>      ji->c.enabled   = false;
>      ji->c.nchannels = as->nchannels;
>      ji->c.opt       = dev->u.jack.in;
> 
> +    ji->c.shutdown_bh = qemu_bh_new(qjack_shutdown_bh, &ji->c);
> +
>      int ret = qjack_client_init(&ji->c);
>      if (ret != 0) {
> +        qemu_bh_delete(ji->c.shutdown_bh);
>          return ret;
>      }
> 
> @@ -555,7 +566,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct
> audsettings *as, return 0;
>  }
> 
> -static void qjack_client_fini(QJackClient *c)
> +static void qjack_client_fini_locked(QJackClient *c)
>  {
>      switch (c->state) {
>      case QJACK_STATE_RUNNING:
> @@ -564,28 +575,40 @@ static void qjack_client_fini(QJackClient *c)
> 
>      case QJACK_STATE_SHUTDOWN:
>          jack_client_close(c->client);
> +        c->client = NULL;
> +
> +        qjack_buffer_free(&c->fifo);
> +        g_free(c->port);
> +
> +        c->state = QJACK_STATE_DISCONNECTED;
>          /* fallthrough */
> 
>      case QJACK_STATE_DISCONNECTED:
>          break;
>      }
> +}
> 
> -    qjack_buffer_free(&c->fifo);
> -    g_free(c->port);
> -
> -    c->state = QJACK_STATE_DISCONNECTED;
> +static void qjack_client_fini(QJackClient *c)
> +{
> +    qemu_mutex_lock(&qjack_shutdown_lock);
> +    qjack_client_fini_locked(c);
> +    qemu_mutex_unlock(&qjack_shutdown_lock);
>  }
> 
>  static void qjack_fini_out(HWVoiceOut *hw)
>  {
>      QJackOut *jo = (QJackOut *)hw;
>      qjack_client_fini(&jo->c);
> +
> +    qemu_bh_delete(jo->c.shutdown_bh);
>  }
> 
>  static void qjack_fini_in(HWVoiceIn *hw)
>  {
>      QJackIn *ji = (QJackIn *)hw;
>      qjack_client_fini(&ji->c);
> +
> +    qemu_bh_delete(ji->c.shutdown_bh);
>  }
> 
>  static void qjack_enable_out(HWVoiceOut *hw, bool enable)
> @@ -662,6 +685,7 @@ static void qjack_info(const char *msg)
> 
>  static void register_audio_jack(void)
>  {
> +    qemu_mutex_init(&qjack_shutdown_lock);
>      audio_driver_register(&jack_driver);
>      jack_set_thread_creator(qjack_thread_creator);
>      jack_set_error_function(qjack_error);

Best regards,
Christian Schoenebeck



