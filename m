Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE18C35240
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 01:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12C72083E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 01:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGlrk8JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12C72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivtV8-0003kX-0p
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 20:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1ivtUW-0003Ly-3b
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 20:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1ivtUU-0007YZ-Kx
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 20:47:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1ivtUU-0007Vy-BC
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 20:47:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so5298774wmb.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 17:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=LgIMJL+PRICvtY930TZl1EeP+JkP75tHEN/F5TwZXcc=;
 b=sGlrk8JC4axTGj4A8jD40XdEXeLld5RRvq5mC0kQrQ3PxfSKNc3lq4G/BCY7JfrJFr
 PDDMGCpU4LYoy94bQF7BAiN1TDyqYr6SznW0svY39gL5LG0D2AvmlSqAYJg+WtSbsq52
 l1VhmHi+csd3vjZ7Jn9t+KTPOuQ/a8hpDEO2YnyNwgjdtCxffC4YZZDV/SK97qhE0P9U
 Rw8YW6ZPREhGBfecAF7XkYQqTwpys0jIKLZBo8H+aDFNuZNbdunDuJmQd5Vr5dEAmcpG
 Xw34kuIYLl6n0y2D+3KMR3JRkQmPxxjsPUHIWNSiE4c1NPqn/1BCfvsvTXQpTCmWtDUb
 2ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=LgIMJL+PRICvtY930TZl1EeP+JkP75tHEN/F5TwZXcc=;
 b=YcCiIxiN4TDyIpU9lbNWFDZTXF/fVxBKdFLIRoDsOAdt9k6xf9+O8y5UeAW1wszw/7
 XjmlmqAUkFx4ZFbcX14ZxeX4CoO6Hw4OD0v/1WAcTwajexHfU90xC4D4ghRV2y0K/L+u
 G/F5Uj93chf77KdWEWVw7iEtfFzrb7MslQSJRbWs3QT4DvpguhIMEVSFdOfMZR11fNXy
 HzGyF2eiIYA2oSVa5uTRa7gmDkrzDiMaSttPdfGgnIGI3EHDc2+fgEbCNsuYgUzfKA4o
 fnw+KgexU8wk6KLUOMelzIZOKMrKqLW/5O8oZG0k8T0LfkU3eG+aLElf4apiTnDfOpLa
 Ts4Q==
X-Gm-Message-State: APjAAAXCT/tRokpJ6A64IUdBrrQmzundB0G+oZ3PtLDEtg69iYHYFaCB
 R99rt0sb7xxhoUAMdoqfQjM=
X-Google-Smtp-Source: APXvYqzrBDfnCTaK5AULrDhzg3taS8kIt8Wy9uUbNUYdanWkomW3Ev6K0g7bZg0wPbJOqD0YURa4ew==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr10948698wmg.146.1580089620735; 
 Sun, 26 Jan 2020 17:47:00 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-6097-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6097:1::d3])
 by smtp.gmail.com with ESMTPSA id 4sm16445411wmg.22.2020.01.26.17.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2020 17:47:00 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 KJ Liew <liewkj@yahoo.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200117182621.GB13724.ref@chuwi-lt0>
 <20200117182621.GB13724@chuwi-lt0>
 <29987343-f835-2280-4457-067d970c9c5e@redhat.com>
Message-ID: <2b889c2c-04ac-c6ef-ae3e-2901492a2824@gmail.com>
Date: Mon, 27 Jan 2020 02:46:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.9) Goanna/4.4
 Interlink/52.9.7282
MIME-Version: 1.0
In-Reply-To: <29987343-f835-2280-4457-067d970c9c5e@redhat.com>
Content-Type: multipart/mixed; boundary="------------4FF108DD90A841D64551106E"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

This is a multi-part message in MIME format.
--------------4FF108DD90A841D64551106E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 2020-01-18 07:30, Philippe Mathieu-Daudé wrote:
> On 1/17/20 7:26 PM, KJ Liew wrote:
>> QEMU Windows has broken dsound backend since the rewrite of audio API in
>> version 4.2.0. Both playback and capture buffers failed to lock with
>> invalid parameters error.
> 
> Fixes: 7fa9754ac88 (dsoundaudio: port to the new audio backend api)

Hmm, I see the old code specified those parameters, but MSDN reads:

If the application passes NULL for the ppvAudioPtr2 and pdwAudioBytes2 
parameters, the lock extends no further than the end of the buffer and 
does not wrap.

Looks like this means that if the lock doesn't fit in the buffer it 
fails instead of truncating it.  I'm sure I tested the code under wine, 
and probably in a win8.1 vm too, and it worked there, maybe it's 
dependent on the windows version or sound driver?

> 
> Cc'ing Zoltán who wrote 7fa9754ac88, and Gerd (the maintainer of this 
> file):
> 
>    $ ./scripts/get_maintainer.pl -f audio/dsoundaudio.c
>    Gerd Hoffmann <kraxel@redhat.com> (maintainer:Audio)
> 
>> --- ../orig/qemu-4.2.0/audio/dsoundaudio.c    2019-12-12 
>> 10:20:47.000000000 -0800
>> +++ ../qemu-4.2.0/audio/dsoundaudio.c    2020-01-17 08:05:46.783966900 
>> -0800
>> @@ -53,6 +53,7 @@
>>   typedef struct {
>>       HWVoiceOut hw;
>>       LPDIRECTSOUNDBUFFER dsound_buffer;
>> +    void *last_buf;
>>       dsound *s;
>>   } DSoundVoiceOut;
>> @@ -414,10 +415,10 @@
>>       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>>       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
>>       HRESULT hr;
>> -    DWORD ppos, act_size;
>> +    DWORD ppos, act_size, last_size;
>>       size_t req_size;
>>       int err;
>> -    void *ret;
>> +    void *ret, *last_ret;
>>       hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
>>       if (FAILED(hr)) {
>> @@ -426,17 +427,24 @@
>>           return NULL;
>>       }
>> +    if (ppos == hw->pos_emul) {
>> +        *size = 0;
>> +        return ds->last_buf;
>> +    }
>> +
>>       req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
>>       req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
>> -    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, 
>> &ret, NULL,
>> -                          &act_size, NULL, false, ds->s);
>> +    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, 
>> &ret, &last_ret,
>> +                          &act_size, &last_size, false, ds->s);
>>       if (err) {
>>           dolog("Failed to lock buffer\n");
>>           *size = 0;
>>           return NULL;
>>       }
>> +    ds->last_buf = g_realloc(ds->last_buf, act_size);
>> +    memcpy(ds->last_buf, ret, act_size);
>>       *size = act_size;
>>       return ret;
>>   }

I don't really understand what's happening here, why do you need that 
memory allocation and memcpy?  This function should return a buffer 
where the caller will write data, that *size = 0; when returning 
ds->last_buf also looks incorrect to me (the calling function won't 
write anything into it).

I'm attaching a patch with a probably better (and totally untested) way 
to do this (if someone can tell me how to copy-paste a patch into 
thunderbird without it messing up long lines, please tell me).


>> @@ -445,6 +453,8 @@
>>   {
>>       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>>       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
>> +    if (len == 0)
>> +        return 0;
>>       int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
>>       if (err) {

Msdn says "The second pointer is needed even if nothing was written to 
the second pointer." so that NULL doesn't look okay.

>> @@ -508,10 +518,10 @@
>>       DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
>>       LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
>>       HRESULT hr;
>> -    DWORD cpos, act_size;
>> +    DWORD cpos, act_size, last_size;
>>       size_t req_size;
>>       int err;
>> -    void *ret;
>> +    void *ret, *last_ret;
>>       hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, 
>> NULL);
>>       if (FAILED(hr)) {
>> @@ -520,11 +530,16 @@
>>           return NULL;
>>       }
>> +    if (cpos == hw->pos_emul) {
>> +        *size = 0;
>> +        return NULL;
>> +    }
>> +
>>       req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
>>       req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
>> -    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, 
>> &ret, NULL,
>> -                         &act_size, NULL, false, ds->s);
>> +    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, 
>> &ret, &last_ret,
>> +                         &act_size, &last_size, false, ds->s);
>>       if (err) {
>>           dolog("Failed to lock buffer\n");
>>           *size = 0;
>>

You're completely ignoring last_ret and last_size here.  Don't you lose 
samples here?  I think it's possible to do something like I posted above 
with output here.

Regards,
Zoltan

--------------4FF108DD90A841D64551106E
Content-Type: text/x-patch; charset=UTF-8;
 name="dsound.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dsound.patch"

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index c265c0094b..b6bc241faa 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -53,6 +53,9 @@ typedef struct {
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
+    void *buffer1, buffer2;
+    DWORD size1, size2;
+    bool has_remaining;
     dsound *s;
 } DSoundVoiceOut;
 
@@ -414,10 +417,16 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
     HRESULT hr;
-    DWORD ppos, act_size;
+    DWORD ppos, act_size1, act_size2;
     size_t req_size;
     int err;
-    void *ret;
+    void *ret1, *ret2;
+
+    if (ds->has_remaining) {
+        ds->has_remaining = false;
+        *size = ds->size2;
+        return ds->buffer2;
+    }
 
     hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
     if (FAILED(hr)) {
@@ -429,15 +438,20 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
     req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
-    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
-                          &act_size, NULL, false, ds->s);
+    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret1, &ret2,
+                          &act_size1, &act_size2, false, ds->s);
     if (err) {
         dolog("Failed to lock buffer\n");
         *size = 0;
         return NULL;
     }
 
-    *size = act_size;
+    *size = act_size1;
+    ds->buffer1 = ret1;
+    ds->buffer2 = ret2;
+    ds->size1 = act_size1;
+    ds->size2 = act_size2;
+    ds->has_remaining = ret2 != NULL;
     return ret;
 }
 
@@ -445,7 +459,16 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
-    int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
+    int err;
+
+    if (ds->has_remaining) {
+        ds->size1 = len;
+        hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
+        return len;
+    }
+
+    *(ds->buffer2 ? &ds->size2 : &ds->size1) = len;
+    err = dsound_unlock_out(dsb, ds->buffer1, ds->buffer2, ds->size1, ds->size2);
 
     if (err) {
         dolog("Failed to unlock buffer!!\n");

--------------4FF108DD90A841D64551106E--

