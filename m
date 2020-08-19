Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D804C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C8F20897
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="Y0GJ5OKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C8F20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Q0o-0005ZF-89
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8Pzn-0004ME-9j
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:27:23 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:41054)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8Pzl-0000w7-7W
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:27:23 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 1E85242765;
 Thu, 20 Aug 2020 01:27:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597850833;
 bh=P0mZm/KVZosvcgg1ag6FG1/GlXGcN5ox6DNv+5jjrOE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y0GJ5OKLwq4PqzW1WymfEyM+qlkC0BV1thx61XXDHXeiEIWmI0uEX1iiIyDGLdAKg
 3nVjH2kYaZWA/lVcpv0Vv5jhhxTbwPFJrr/GF8SBnuKFD7L4piP/LRdTqp4HO13dKI
 pgQ5fgzdLsVH+m9c2UUgs21//S1Omq/WUTEdR2b0=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 0A25A89DE3;
 Thu, 20 Aug 2020 01:27:13 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Aug 2020 01:27:13 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
In-Reply-To: <5029913.bOW1W81TKx@silver>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <20200819062940.52774-2-geoff@hostfission.com> <5029913.bOW1W81TKx@silver>
Message-ID: <7fca183cc66cf07f6ba72eabea8a44cf@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 11:27:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-08-20 01:21, Christian Schoenebeck wrote:
> On Mittwoch, 19. August 2020 08:29:39 CEST Geoffrey McRae wrote:
>> This change registers a bottom handler to close the JACK client
>> connection when a server shutdown signal is recieved. Without this
>> libjack2 attempts to "clean up" old clients and causes a use after 
>> free
>> segfault.
>> 
>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>> ---
> 
> Looks much better now, but ...
> 
>>  audio/jackaudio.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>> 
>> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
>> index 72ed7c4929..b0da5cd00b 100644
>> --- a/audio/jackaudio.c
>> +++ b/audio/jackaudio.c
>> @@ -25,6 +25,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/module.h"
>>  #include "qemu/atomic.h"
>> +#include "qemu/main-loop.h"
>>  #include "qemu-common.h"
>>  #include "audio.h"
>> 
>> @@ -63,6 +64,7 @@ typedef struct QJackClient {
>>      QJackState      state;
>>      jack_client_t  *client;
>>      jack_nframes_t  freq;
>> +    QEMUBH         *shutdown_bh;
>> 
>>      struct QJack   *j;
>>      int             nchannels;
>> @@ -306,21 +308,27 @@ static int qjack_xrun(void *arg)
>>      return 0;
>>  }
>> 
>> +static void qjack_shutdown_bh(void *opaque)
>> +{
>> +    QJackClient *c = (QJackClient *)opaque;
>> +    qjack_client_fini(c);
>> +}
>> +
>>  static void qjack_shutdown(void *arg)
>>  {
>>      QJackClient *c = (QJackClient *)arg;
>> -    c->state = QJACK_STATE_SHUTDOWN;
>> +    c->state       = QJACK_STATE_SHUTDOWN;
> 
> White space changes are not much embraced on high traffic projects BTW.

This change is unintentional and was missed in the rollback from the 
prior patch version.

> 
>> +    qemu_bh_schedule(c->shutdown_bh);
>>  }
>> 
>>  static void qjack_client_recover(QJackClient *c)
>>  {
>> -    if (c->state == QJACK_STATE_SHUTDOWN) {
>> -        qjack_client_fini(c);
>> +    if (c->state != QJACK_STATE_DISCONNECTED) {
>> +        return;
>>      }
>> 
>>      /* packets is used simply to throttle this */
>> -    if (c->state == QJACK_STATE_DISCONNECTED &&
>> -        c->packets % 100 == 0) {
>> +    if (c->packets % 100 == 0) {
>> 
>>          /* if enabled then attempt to recover */
>>          if (c->enabled) {
>> @@ -417,6 +425,10 @@ static int qjack_client_init(QJackClient *c)
>>          options |= JackServerName;
>>      }
>> 
>> +    if (!c->shutdown_bh) {
>> +        c->shutdown_bh = qemu_bh_new(qjack_shutdown_bh, c);
>> +    }
>> +
> 
> Where is qemu_bh_delete() ?

Whoops... I will correct this :)

> 
>>      c->client = jack_client_open(client_name, options, &status,
>>        c->opt->server_name);
>> 
>> @@ -489,8 +501,6 @@ static int qjack_init_out(HWVoiceOut *hw, struct
>> audsettings *as, QJackOut *jo  = (QJackOut *)hw;
>>      Audiodev *dev = (Audiodev *)drv_opaque;
>> 
>> -    qjack_client_fini(&jo->c);
>> -
>>      jo->c.out       = true;
>>      jo->c.enabled   = false;
>>      jo->c.nchannels = as->nchannels;
>> @@ -525,8 +535,6 @@ static int qjack_init_in(HWVoiceIn *hw, struct
>> audsettings *as, QJackIn  *ji  = (QJackIn *)hw;
>>      Audiodev *dev = (Audiodev *)drv_opaque;
>> 
>> -    qjack_client_fini(&ji->c);
>> -
>>      ji->c.out       = false;
>>      ji->c.enabled   = false;
>>      ji->c.nchannels = as->nchannels;
>> @@ -557,6 +565,8 @@ static int qjack_init_in(HWVoiceIn *hw, struct
>> audsettings *as,
>> 
>>  static void qjack_client_fini(QJackClient *c)
>>  {
>> +    qemu_bh_cancel(c->shutdown_bh);
>> +
> 
> Looks like a potential race. Quote from the API doc of 
> qemu_bh_cancel():
> 
> 	"While cancellation itself is also wait-free and thread-safe, it can 
> of
> 	course race with the loop that executes bottom halves unless you are
> 	holding the iothread mutex.  This makes it mostly useless if you are 
> not
> 	holding the mutex."
> 

Noted. How does one go about holding the iothread mutex?

>>      switch (c->state) {
>>      case QJACK_STATE_RUNNING:
>>          jack_deactivate(c->client);
>> @@ -564,6 +574,7 @@ static void qjack_client_fini(QJackClient *c)
>> 
>>      case QJACK_STATE_SHUTDOWN:
>>          jack_client_close(c->client);
>> +        c->client = NULL;
>>          /* fallthrough */
>> 
>>      case QJACK_STATE_DISCONNECTED:
> 
> Best regards,
> Christian Schoenebeck

