Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D910C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B1D2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZcoBJh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B1D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTaX-0007id-49
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isTZf-00071p-7S
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isTZa-0003XS-RX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:30:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isTZa-0003Vw-Mu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579275010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eE7RpsxePY2U+nZWG4HAQoW8CtMVTu+V3PWEh+skSU=;
 b=TZcoBJh66AqUt+kRY8J4bRexHClZ2ejWDKjP1BQ53nsXGCCRTnlMwfWzhPyvjlfFNkNKuO
 IM7TFaSqMz+vV4A3cKvaQRabseY/QnGrm3wJdUMeYckZIRSqz2mrEFAzVhnj5BH+rAlYIa
 j/6ogM/+wFMtjhUTTETr7FNd3uS8bxw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Iwd4fCVRMjCGgCmI5e0Cvw-1; Fri, 17 Jan 2020 10:30:08 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so2400500wma.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 07:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6ZDySox3Cu8tBJcOSTemEWcvYrhIlSqE4WsxGaKMS70=;
 b=rD9KXnVaHmB/B/pRPro5iHouebVvLlILogJlK14maKaXz5WqhZeLMX8GSgexjCxadu
 tiO2jpTG1xAd2CjESilH2XEQ89r7RLIdnlEryuiMH3TANkv07qVcnKj0MYu1ue2ytDMU
 9ptofii2OUZdo3RO0Kf+ZZ59c1A8n2gzfDGufVo6N6V8RVJOxvZoc+bMqafuKpj9V6I2
 JCwZmmv2L29KVXU4LCglczE29sfztMYvcJXg5mtHG8NPW3inDBBttibxjGY7nrP6aFWe
 KCZM97tEzPzMhtSozzuqbc9RP4x8Pjz/cyJpIrdP/CilcVe3wW9j10aR9SCo3wDjKHh7
 jvIA==
X-Gm-Message-State: APjAAAX16ybf25S4Vi7rNBvF+3ajt4SUmE0zQLVDoiGGViwoVAnt6pMK
 mD42WhnxWuiV8OBxSnxNZeIoncv4OACWUvFf0wqCZKKKWTJ3Tz5VNrg0BQv76yNxm/l2MbJGSvd
 Nroo+fElUpeOAr4I=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr3747879wrv.308.1579275007603; 
 Fri, 17 Jan 2020 07:30:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxptj2KuvUwYef1dZnuPl0wbdJCCjj07o99qJrGDX4LiKGTDDzkitmrduwhdcQ5/lxVDTPLJA==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr3747850wrv.308.1579275007282; 
 Fri, 17 Jan 2020 07:30:07 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g7sm34246112wrq.21.2020.01.17.07.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 07:30:06 -0800 (PST)
Subject: Re: [PATCH 101/104] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-102-dgilbert@redhat.com>
 <73aa1b6c-612e-363e-dd49-04d1ba4f88f8@redhat.com>
 <20200117152811.GJ3209@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7da3f99-7341-93e2-cf47-222bb7e33ec8@redhat.com>
Date: Fri, 17 Jan 2020 16:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117152811.GJ3209@work-vm>
Content-Language: en-US
X-MC-Unique: Iwd4fCVRMjCGgCmI5e0Cvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 4:28 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> On 12/12/19 5:39 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> When running with multiple threads it can be tricky to handle
>>> FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
>>> parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
>>> malicious clients cannot trigger race conditions.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>    tools/virtiofsd/fuse_i.h        |  1 +
>>>    tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
>>>    2 files changed, 19 insertions(+)
>>>
>>> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
>>> index d0679508cd..8a4a05b319 100644
>>> --- a/tools/virtiofsd/fuse_i.h
>>> +++ b/tools/virtiofsd/fuse_i.h
>>> @@ -61,6 +61,7 @@ struct fuse_session {
>>>        struct fuse_req list;
>>>        struct fuse_req interrupts;
>>>        pthread_mutex_t lock;
>>> +    pthread_rwlock_t init_rwlock;
>>>        int got_destroy;
>>>        int broken_splice_nonblock;
>>>        uint64_t notify_ctr;
>>> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
>>> index 10f478b00c..9f01c05e3e 100644
>>> --- a/tools/virtiofsd/fuse_lowlevel.c
>>> +++ b/tools/virtiofsd/fuse_lowlevel.c
>>> @@ -2431,6 +2431,19 @@ void fuse_session_process_buf_int(struct fuse_se=
ssion *se,
>>>        req->ctx.pid =3D in->pid;
>>>        req->ch =3D ch ? fuse_chan_get(ch) : NULL;
>>> +    /*
>>> +     * INIT and DESTROY requests are serialized, all other request typ=
es
>>> +     * run in parallel.  This prevents races between FUSE_INIT and ord=
inary
>>> +     * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, =
and
>>
>> typo "FUSE_INIT and FUSE_INIT" -> "FUSE_INIT and CUSE_INIT"?
>=20
> No, don't think so; I think it's suggesting a race between two
> FUSE_INIT's.

And CUSE_INIT is a subtype of FUSE_INIT, OK.

>=20
> Dave
>=20
>>> +     * FUSE_DESTROY and FUSE_DESTROY.
>>> +     */
>>> +    if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT ||
>>> +        in->opcode =3D=3D FUSE_DESTROY) {
>>> +        pthread_rwlock_wrlock(&se->init_rwlock);
>>> +    } else {
>>> +        pthread_rwlock_rdlock(&se->init_rwlock);
>>> +    }
>>> +
>>>        err =3D EIO;
>>>        if (!se->got_init) {
>>>            enum fuse_opcode expected;
>>> @@ -2488,10 +2501,13 @@ void fuse_session_process_buf_int(struct fuse_s=
ession *se,
>>>        } else {
>>>            fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
>>>        }
>>> +
>>> +    pthread_rwlock_unlock(&se->init_rwlock);
>>>        return;
>>>    reply_err:
>>>        fuse_reply_err(req, err);
>>> +    pthread_rwlock_unlock(&se->init_rwlock);
>>>    }
>>>    #define LL_OPTION(n, o, v)                     \
>>> @@ -2538,6 +2554,7 @@ void fuse_session_destroy(struct fuse_session *se=
)
>>>                se->op.destroy(se->userdata);
>>>            }
>>>        }
>>> +    pthread_rwlock_destroy(&se->init_rwlock);
>>>        pthread_mutex_destroy(&se->lock);
>>>        free(se->cuse_data);
>>>        if (se->fd !=3D -1) {
>>> @@ -2631,6 +2648,7 @@ struct fuse_session *fuse_session_new(struct fuse=
_args *args,
>>>        list_init_req(&se->list);
>>>        list_init_req(&se->interrupts);
>>>        fuse_mutex_init(&se->lock);
>>> +    pthread_rwlock_init(&se->init_rwlock, NULL);
>>>        memcpy(&se->op, op, op_size);
>>>        se->owner =3D getuid();
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


