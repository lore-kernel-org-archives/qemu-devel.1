Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966BC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68AC2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkUN3cwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68AC2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5er-0002Aa-QX
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5dF-0001Ba-GQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5dB-0001XG-NE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:13:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS5dB-0001Rd-6S
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587762783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npEaqXurWEGtB8NqxirVKVI3LG7velqWZrb0mGUA5ZA=;
 b=IkUN3cwjds0/9lIzEGr0pzcExP1WbgFylVNry0e/jrMGJ8UoyERQl+gM4OW3ld91FLdx0J
 FfTLhJgee3b0OX5oGKsUcI5INNkpHrXVqpQ/+OWqAt4J3CwWLer5Hf4jjshgfWuFIbJwIN
 XqGIJNIQp9x6bIO7WV/kOAf4g3mizGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-R0gSi7F_OBuRDMYwB4aa0Q-1; Fri, 24 Apr 2020 17:12:58 -0400
X-MC-Unique: R0gSi7F_OBuRDMYwB4aa0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B89545F;
 Fri, 24 Apr 2020 21:12:57 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 172EA60C05;
 Fri, 24 Apr 2020 21:12:55 +0000 (UTC)
Subject: Re: [RFC patch v1 1/3] qemu-file: introduce current buffer
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-2-git-send-email-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3bc64dd3-780c-47c1-5f35-12d4bcafc92c@redhat.com>
Date: Fri, 24 Apr 2020 16:12:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586776334-641239-2-git-send-email-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:11:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 6:12 AM, Denis Plotnikov wrote:
> To approach async wrtiting in the further commits, the buffer

writing

> allocated in QEMUFile struct is replaced with the link to the
> current buffer. We're going to use many buffers to write the
> qemu file stream to the unerlying storage asynchronously. The

underlying

> current buffer points out to the buffer is currently filled
> with data.

This sentence is confusing.  I'd suggest: The current_buf pointer tracks 
which buffer is currently filled with data.

> 
> This patch doesn't add any features to qemu-file and doesn't
> change any qemu-file behavior.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   include/qemu/typedefs.h |   1 +
>   migration/qemu-file.c   | 156 +++++++++++++++++++++++++++++-------------------
>   2 files changed, 95 insertions(+), 62 deletions(-)
> 
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 375770a..88dce54 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -97,6 +97,7 @@ typedef struct QDict QDict;
>   typedef struct QEMUBH QEMUBH;
>   typedef struct QemuConsole QemuConsole;
>   typedef struct QEMUFile QEMUFile;
> +typedef struct QEMUFileBuffer QEMUFileBuffer;
>   typedef struct QemuLockable QemuLockable;
>   typedef struct QemuMutex QemuMutex;
>   typedef struct QemuOpt QemuOpt;
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 1c3a358..285c6ef 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -33,6 +33,17 @@
>   #define IO_BUF_SIZE 32768
>   #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>   
> +QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
> +
> +struct QEMUFileBuffer {
> +    int buf_index;
> +    int buf_size; /* 0 when writing */
> +    uint8_t *buf;
> +    unsigned long *may_free;

Do we really want something that compiles differently on 32- vs. 64-bit?
/me reads ahead...

> +    struct iovec *iov;
> +    unsigned int iovcnt;
> +};
> +
>   struct QEMUFile {
>       const QEMUFileOps *ops;
>       const QEMUFileHooks *hooks;
> @@ -43,18 +54,12 @@ struct QEMUFile {
>   
>       int64_t pos; /* start of buffer when writing, end of buffer
>                       when reading */
> -    int buf_index;
> -    int buf_size; /* 0 when writing */
> -    uint8_t buf[IO_BUF_SIZE];
> -
> -    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);

...ah, you're replacing a bitmap, and our bitmap code _does_ use 'long' 
as its core for optimum speed (which overcomes the fact that it does 
mean annoying differences on 32- vs. 64-bit).

> -    struct iovec iov[MAX_IOV_SIZE];
> -    unsigned int iovcnt;
> -
>       int last_error;
>       Error *last_error_obj;
>       /* has the file has been shutdown */
>       bool shutdown;
> +    /* currently used buffer */
> +    QEMUFileBuffer *current_buf;
>   };
>   

Most of the patch is mechanical conversion to the rearranged struct.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


