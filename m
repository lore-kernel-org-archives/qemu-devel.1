Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDC9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6E1246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMdx/FsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6E1246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cJ8-0002zK-17
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cIW-0002Zi-KT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cIU-0002WK-J0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:51:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cIU-0002Vq-Eh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582883464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZw5jQYjcDfbMf2KKAOAQa8DSUYomQrICOHiEnQwxo8=;
 b=CMdx/FsUWvHKiGfVy0ZagXr96ZqqR+3xeRrdMl2M35i2cHVIu2Ug8DVKr8vFT6qN5YRj9N
 F1+jMd8bEwMOVqjQVJfmS81j2JjkevvVEpD3K1RbeQYUPMHHOWsxQE9szFVm5Ym3hpaAEp
 34VGBqW85bA/lxk27N+BVtH5x2gYleo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-b9Vp9r0jNGWWdyoyHo4mIw-1; Fri, 28 Feb 2020 04:51:02 -0500
X-MC-Unique: b9Vp9r0jNGWWdyoyHo4mIw-1
Received: by mail-wm1-f72.google.com with SMTP id y7so939709wmd.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 01:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVE//eV8geHQEPB9bJcHY67RDdg/iwsDRQYjAGXW/5g=;
 b=YpunYTit5/SUKkZ0owqqAZctJxQIdtmZr9Tz9p7bSV2+GsDVkDyQIjZdqe/D2/gd1t
 ou2j0SrcmQgwA62POokk/vpvCoj009DNrqTPOdIIa+YQMogxldJfVUKIc+XpUBaHdrsx
 qLGgmv/oo3UicZZH+7RwwqdgyApwOnQnm0PgDoWCOrVAr7PjI9ayo3jibm5N02HhZdsD
 IS9Ct0dS6nqMh/VR5hULNH4qW1dpxVGYqUpbG0QjTRwj0kNkwFicllvWufJM6b4WSz1+
 i9KCkxwq9AxcK4YKNPdNKeRyHMB8xLTEJh4Cioqe+hkajNp4UiPdxfrIaHt/4csk1ncY
 r/Jw==
X-Gm-Message-State: APjAAAV9MXOH1+IGWKPweqs0v5TGXiaeCTItC91IWY3gW0ygtGaHRTsi
 5vt6sjg8wW7Az5AYBA/XlAE0v6B/h/kQLOJ0Bun3kIBLKXPwy9DcF7ZLZeYIIbj+NSsps0Uo7hR
 KRttf3X97j5tA1TU=
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr3907541wmg.169.1582883461052; 
 Fri, 28 Feb 2020 01:51:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoIsSvU4ZKmJX5BcCRDwKFu+sxAiK3UFmvfrGBKydhuMDSMX7WsPN+4QkJIWCuBkFQaxr2aA==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr3907505wmg.169.1582883460556; 
 Fri, 28 Feb 2020 01:51:00 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id r1sm11078824wrx.11.2020.02.28.01.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 01:50:59 -0800 (PST)
Subject: Re: [PATCH v2 2/6] util: Replace fprintf(stderr, "*\n" with
 error_report()
To: Markus Armbruster <armbru@redhat.com>
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-3-philmd@redhat.com> <87ftevma26.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12c7c23b-2a6f-6a54-5974-13492d6fcd4f@redhat.com>
Date: Fri, 28 Feb 2020 10:50:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87ftevma26.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 8:43 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> From: Alistair Francis <alistair.francis@xilinx.com>
>>
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
>>
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|er=
ror_report("\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
>>      {} +
>> find ./* -type f -exec sed -i \
>>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
>>      {} +
>>
>> The error in aio_poll() was removed manually.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <f71203227749e2afb8564b3388b2b34f6652b009.1510181732.git.ali=
stair.francis@xilinx.com>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> [PMD: Rebased]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Alistair Francis <Alistair.Francis@wdc.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> ---
>>   util/coroutine-sigaltstack.c |  3 ++-
>>   util/mmap-alloc.c            | 11 ++++++-----
>>   util/module.c                | 13 ++++++-------
>>   util/osdep.c                 |  4 ++--
>>   util/oslib-posix.c           |  3 ++-
>>   util/oslib-win32.c           |  3 ++-
>>   util/qemu-coroutine.c        | 10 +++++-----
>>   util/qemu-thread-posix.c     |  5 +++--
>>   util/qemu-thread-win32.c     |  5 +++--
>>   util/qemu-timer-common.c     |  3 ++-
>>   10 files changed, 33 insertions(+), 27 deletions(-)
>>
>> diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
>> index f6fc49a0e5..63decd4d1d 100644
>> --- a/util/coroutine-sigaltstack.c
>> +++ b/util/coroutine-sigaltstack.c
>> @@ -29,6 +29,7 @@
>>   #include <pthread.h>
>>   #include "qemu-common.h"
>>   #include "qemu/coroutine_int.h"
>> +#include "qemu/error-report.h"
>>  =20
>>   typedef struct {
>>       Coroutine base;
>> @@ -80,7 +81,7 @@ static void __attribute__((constructor)) coroutine_ini=
t(void)
>>  =20
>>       ret =3D pthread_key_create(&thread_state_key, qemu_coroutine_threa=
d_cleanup);
>>       if (ret !=3D 0) {
>> -        fprintf(stderr, "unable to create leader key: %s\n", strerror(e=
rrno));
>> +        error_report("unable to create leader key: %s", strerror(errno)=
);
>>           abort();
>>       }
>>   }
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index 27dcccd8ec..3ac6e10404 100644
>> --- a/util/mmap-alloc.c
>> +++ b/util/mmap-alloc.c
>> @@ -18,6 +18,7 @@
>>   #endif /* CONFIG_LINUX */
>>  =20
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/mmap-alloc.h"
>>   #include "qemu/host-utils.h"
>>  =20
>> @@ -63,7 +64,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>>           } while (ret !=3D 0 && errno =3D=3D EINTR);
>>  =20
>>           if (ret !=3D 0) {
>> -            fprintf(stderr, "Couldn't statfs() memory path: %s\n",
>> +            error_report("Couldn't statfs() memory path: %s",
>>                       strerror(errno));
>=20
> Indentation is off.
>=20
>>               exit(1);
>>           }
>> @@ -160,10 +161,10 @@ void *qemu_ram_mmap(int fd,
>>                   len =3D 0;
>>               }
>>               file_name[len] =3D '\0';
>> -            fprintf(stderr, "Warning: requesting persistence across cra=
shes "
>> -                    "for backend file %s failed. Proceeding without "
>> -                    "persistence, data might become corrupted in case o=
f host "
>> -                    "crash.\n", file_name);
>> +            error_report("Warning: requesting persistence across crashe=
s "
>> +                         "for backend file %s failed. Proceeding withou=
t "
>> +                         "persistence, data might become corrupted in c=
ase "
>> +                         "of host crash.", file_name);
>=20
> This should be something like
>=20
>                 warn_report("requesting persistence across crashes"
>                             " for backend file %s failed",
>                             file_name);
>                 error_printf("Proceeding without persistence, data might"
>                              " become corrupted in case of host crash.\n"=
);
>=20
> Precedence: commit db0754df88 "file-posix: Use error API properly".
>=20
>>               g_free(proc_link);
>>               g_free(file_name);
>>           }
>> diff --git a/util/module.c b/util/module.c
>> index 236a7bb52a..28efa1f891 100644
>> --- a/util/module.c
>> +++ b/util/module.c
>> @@ -19,6 +19,7 @@
>>   #endif
>>   #include "qemu/queue.h"
>>   #include "qemu/module.h"
>> +#include "qemu/error-report.h"
>>  =20
>>   typedef struct ModuleEntry
>>   {
>> @@ -130,19 +131,17 @@ static int module_load_file(const char *fname)
>>  =20
>>       g_module =3D g_module_open(fname, G_MODULE_BIND_LAZY | G_MODULE_BI=
ND_LOCAL);
>>       if (!g_module) {
>> -        fprintf(stderr, "Failed to open module: %s\n",
>> -                g_module_error());
>> +        error_report("Failed to open module: %s", g_module_error());
>>           ret =3D -EINVAL;
>>           goto out;
>>       }
>>       if (!g_module_symbol(g_module, DSO_STAMP_FUN_STR, (gpointer *)&sym=
)) {
>> -        fprintf(stderr, "Failed to initialize module: %s\n",
>> -                fname);
>> +        error_report("Failed to initialize module: %s", fname);
>>           /* Print some info if this is a QEMU module (but from differen=
t build),
>>            * this will make debugging user problems easier. */
>>           if (g_module_symbol(g_module, "qemu_module_dummy", (gpointer *=
)&sym)) {
>> -            fprintf(stderr,
>> -                    "Note: only modules from the same build can be load=
ed.\n");
>> +            error_report("Note: "
>> +                         "only modules from the same build can be loade=
d.");
>=20
> Use error_printf() to print the additional note.
>=20
>>           }
>>           g_module_close(g_module);
>>           ret =3D -EINVAL;
>> @@ -178,7 +177,7 @@ bool module_load_one(const char *prefix, const char =
*lib_name)
>>       static GHashTable *loaded_modules;
>>  =20
>>       if (!g_module_supported()) {
>> -        fprintf(stderr, "Module is not supported by system.\n");
>> +        error_report("Module is not supported by system.");
>>           return false;
>>       }
>>  =20
>> diff --git a/util/osdep.c b/util/osdep.c
>> index f7d06050f7..ef40ae512a 100644
>> --- a/util/osdep.c
>> +++ b/util/osdep.c
>> @@ -484,7 +484,7 @@ void fips_set_state(bool requested)
>>   #endif /* __linux__ */
>>  =20
>>   #ifdef _FIPS_DEBUG
>> -    fprintf(stderr, "FIPS mode %s (requested %s)\n",
>> +    error_report("FIPS mode %s (requested %s)",
>>               (fips_enabled ? "enabled" : "disabled"),
>>               (requested ? "enabled" : "disabled"));
>>   #endif
>> @@ -511,7 +511,7 @@ int socket_init(void)
>>       ret =3D WSAStartup(MAKEWORD(2, 2), &Data);
>>       if (ret !=3D 0) {
>>           err =3D WSAGetLastError();
>> -        fprintf(stderr, "WSAStartup: %d\n", err);
>> +        error_report("WSAStartup: %d", err);
>>           return -1;
>>       }
>>       atexit(socket_cleanup);
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 897e8f3ba6..4977594a43 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -35,6 +35,7 @@
>>   #include "sysemu/sysemu.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/sockets.h"
>>   #include "qemu/thread.h"
>>   #include <libgen.h>
>> @@ -170,7 +171,7 @@ fail_close:
>>   void *qemu_oom_check(void *ptr)
>>   {
>>       if (ptr =3D=3D NULL) {
>> -        fprintf(stderr, "Failed to allocate memory: %s\n", strerror(err=
no));
>> +        error_report("Failed to allocate memory: %s", strerror(errno));
>>           abort();
>>       }
>>       return ptr;
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index e9b14ab178..84b937865a 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -39,6 +39,7 @@
>>   #include "trace.h"
>>   #include "qemu/sockets.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>  =20
>>   /* this must come after including "trace.h" */
>>   #include <shlobj.h>
>> @@ -46,7 +47,7 @@
>>   void *qemu_oom_check(void *ptr)
>>   {
>>       if (ptr =3D=3D NULL) {
>> -        fprintf(stderr, "Failed to allocate memory: %lu\n", GetLastErro=
r());
>> +        error_report("Failed to allocate memory: %lu", GetLastError());
>>           abort();
>>       }
>>       return ptr;
>> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
>> index c3caa6c770..62d1dd09df 100644
>> --- a/util/qemu-coroutine.c
>> +++ b/util/qemu-coroutine.c
>> @@ -14,6 +14,7 @@
>>  =20
>>   #include "qemu/osdep.h"
>>   #include "trace.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/thread.h"
>>   #include "qemu/atomic.h"
>>   #include "qemu/coroutine.h"
>> @@ -125,14 +126,13 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Cor=
outine *co)
>>            * cause us to enter it twice, potentially even after the coro=
utine has
>>            * been deleted */
>>           if (scheduled) {
>> -            fprintf(stderr,
>> -                    "%s: Co-routine was already scheduled in '%s'\n",
>> -                    __func__, scheduled);
>> +            error_report("%s: Co-routine was already scheduled in '%s'"=
,
>> +                         __func__, scheduled);
>>               abort();
>>           }
>>  =20
>>           if (to->caller) {
>> -            fprintf(stderr, "Co-routine re-entered recursively\n");
>> +            error_report("Co-routine re-entered recursively");
>>               abort();
>>           }
>>  =20
>> @@ -185,7 +185,7 @@ void coroutine_fn qemu_coroutine_yield(void)
>>       trace_qemu_coroutine_yield(self, to);
>>  =20
>>       if (!to) {
>> -        fprintf(stderr, "Co-routine is yielding to no one\n");
>> +        error_report("Co-routine is yielding to no one");
>>           abort();
>>       }
>>  =20
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 838980aaa5..b4d8de376c 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -14,6 +14,7 @@
>>   #include "qemu/thread.h"
>>   #include "qemu/atomic.h"
>>   #include "qemu/notify.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu-thread-common.h"
>>  =20
>>   static bool name_threads;
>> @@ -25,14 +26,14 @@ void qemu_thread_naming(bool enable)
>>   #ifndef CONFIG_THREAD_SETNAME_BYTHREAD
>>       /* This is a debugging option, not fatal */
>>       if (enable) {
>> -        fprintf(stderr, "qemu: thread naming not supported on this host=
\n");
>> +        error_report("qemu: thread naming not supported on this host");
>=20
> This isn't an error.  It's in response to -name debug-threads=3Don, and
> tells the user debug-threads=3Don is being ignored.  Let's use
> warn_report().
>=20
> Drop the "qemu: ", please; error_report() & friends take care of that.
> More of the same below.
>=20
>>       }
>>   #endif
>>   }
>>  =20
>>   static void error_exit(int err, const char *msg)
>>   {
>> -    fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
>> +    error_report("qemu: %s: %s", msg, strerror(err));
>>       abort();
>>   }
>>  =20
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index 56a83333da..9bed338d7e 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu-common.h"
>>   #include "qemu/thread.h"
>>   #include "qemu/notify.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu-thread-common.h"
>>   #include <process.h>
>>  =20
>> @@ -25,7 +26,7 @@ void qemu_thread_naming(bool enable)
>>       /* But note we don't actually name them on Windows yet */
>>       name_threads =3D enable;
>>  =20
>> -    fprintf(stderr, "qemu: thread naming not supported on this host\n")=
;
>> +    error_report("qemu: thread naming not supported on this host");
>=20
> Likewise.

Thanks for your review. I'll drop the changes in util/oslib-win32.c for=20
for now, and add a note in my TODO for after the 5.0 release.

>=20
>>   }
>>  =20
>>   static void error_exit(int err, const char *msg)
>> @@ -34,7 +35,7 @@ static void error_exit(int err, const char *msg)
>>  =20
>>       FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE=
_BUFFER,
>>                     NULL, err, 0, (LPTSTR)&pstr, 2, NULL);
>> -    fprintf(stderr, "qemu: %s: %s\n", msg, pstr);
>> +    error_report("qemu: %s: %s", msg, pstr);
>>       LocalFree(pstr);
>>       abort();
>>   }
>> diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
>> index baf3317f74..527944da1c 100644
>> --- a/util/qemu-timer-common.c
>> +++ b/util/qemu-timer-common.c
>> @@ -23,6 +23,7 @@
>>    */
>>   #include "qemu/osdep.h"
>>   #include "qemu/timer.h"
>> +#include "qemu/error-report.h"
>>  =20
>>   /***********************************************************/
>>   /* real time host monotonic timer */
>> @@ -37,7 +38,7 @@ static void __attribute__((constructor)) init_get_cloc=
k(void)
>>       int ret;
>>       ret =3D QueryPerformanceFrequency(&freq);
>>       if (ret =3D=3D 0) {
>> -        fprintf(stderr, "Could not calibrate ticks\n");
>> +        error_report("Could not calibrate ticks");
>>           exit(1);
>>       }
>>       clock_freq =3D freq.QuadPart;
>=20


