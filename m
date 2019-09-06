Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B1C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEB420838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="p3HwjDyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEB420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JO6-0007f2-1D
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 14:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <scw@google.com>) id 1i6JM4-00076B-VV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <scw@google.com>) id 1i6JM2-0004K9-VQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:53:08 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <scw@google.com>) id 1i6JM2-0004Hs-52
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:53:06 -0400
Received: by mail-io1-xd41.google.com with SMTP id p12so15044644iog.5
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z3dfBY7JQz9BktUuuaqV7uU9OBPwFADOL6tikkgBxrQ=;
 b=p3HwjDyx4+mDIWsU+wxswI9FnoDMejyjS8qaHpLOLSHlZTsD03qdAGVpp1KnjFUjZN
 5IYAC21cjh3amUKf01/Jb0V6+qYRn46HFDQxwIpT4zWvPYhfhT+FqiHC5Lt0XWZqHt2o
 kph1L+OPAtyQ51UXTSam7OYqdHvlDTTtGfOhD8uwy5DudCf4lWtTVnfPyYgRUEbSuE5M
 fFMsF4Nec0JWseydFG4rt4aba+NI1Cu8ejKWzTat7MeT0fM4p/+ewq411Y+bTuFJ3nCX
 5lxVhsvBTQp9v0Hq8zBzi0dSWEeTE2BH98xAqKGCiY8LcMa22uJZfs6Nxx5+Lkk/JrN6
 1WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z3dfBY7JQz9BktUuuaqV7uU9OBPwFADOL6tikkgBxrQ=;
 b=sjEZ/6/N82OuyYsqnzEwWce0cY1MfM4WJbGToR7OeFFZ7URZr5L760kOn9JYDNBUbT
 XNczuxY2lfNSjrvQNt15Fmsu3rhW196n7zzAHwlYtlgrrOGkbxUh/v4dOWny0IxG67O7
 IfnQf56KwXjBECUCz24aShXbf/SSLms4pKKF1cplzWP1NMxlAkXaayh6Lc1KATWExT3M
 OghBcgB4mtAgkAFJTd8dYd6/3wYTvE7rgiwbmwNK8OpO3mVikd3yksgA+y5cSUsePcWQ
 weLWPSYhpEAYkhYsCgmqJlHY+lRCcfA2ZBAzS16btLHvoWq38uQQZTLypCKsVzNTV1kX
 OeWw==
X-Gm-Message-State: APjAAAVAU7KLBTIzPLpfcVzkU/U5bBvnKK7VSqctH0tlhR3q2DT71zx9
 CDARWgvD9V4CQTeCIAekJZzy9HFBBkEN5s0b7S7PRA==
X-Google-Smtp-Source: APXvYqwlhzwckuW0S8L0s5i+BnjwOPy8wMwVLX7ctsNJKKIEIu24hEq117Wv6TBN8SVMPcoRSxOj52v1uPaLDUCwgqQ=
X-Received: by 2002:a02:92:: with SMTP id 140mr11395301jaa.98.1567795983740;
 Fri, 06 Sep 2019 11:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190821201921.106902-1-scw@google.com>
In-Reply-To: <20190821201921.106902-1-scw@google.com>
Date: Fri, 6 Sep 2019 11:52:52 -0700
Message-ID: <CAF3nBxh2uk0_kUMWNnq799BZKKqXSWctvJ+E=T2aqpFcARXNNw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000becfdf0591e6f27c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] linux-user: hijack open() for thread
 directories
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000becfdf0591e6f27c
Content-Type: text/plain; charset="UTF-8"

Ping. Any comments on this? Patchwork:
http://patchwork.ozlabs.org/patch/1151167/

On Wed, Aug 21, 2019 at 1:19 PM Shu-Chun Weng <scw@google.com> wrote:

> Besides /proc/self|<pid>, files under /proc/thread-self and
> /proc/self|<pid>/task/<tid> also expose host information to the guest
> program. This patch adds them to the hijack infrastracture. Note that
> is_proc_myself() does not check if the <tid> matches the current thread
> and is thus only suitable for procfs files that are identical for all
> threads in the same process.
>
> Behavior verified with guest program:
>
> long main_thread_tid;
>
> long gettid() {
>   return syscall(SYS_gettid);
> }
>
> void print_info(const char* cxt, const char* dir) {
>   char buf[1024];
>   FILE* fp;
>
>   snprintf(buf, sizeof(buf), "%s/cmdline", dir);
>   fp = fopen(buf, "r");
>
>   if (fp == NULL) {
>     printf("%s: can't open %s\n", cxt, buf);
>   } else {
>     fgets(buf, sizeof(buf), fp);
>     printf("%s %s cmd: %s\n", cxt, dir, buf);
>     fclose(fp);
>   }
>
>   snprintf(buf, sizeof(buf), "%s/maps", dir);
>   fp = fopen(buf, "r");
>
>   if (fp == NULL) {
>     printf("%s: can't open %s\n", cxt, buf);
>   } else {
>     char seen[128][128];
>     int n = 0, is_new = 0;
>     while(fgets(buf, sizeof(buf), fp) != NULL) {
>       const char* p = strrchr(buf, ' ');
>       if (p == NULL || *(p + 1) == '\n') {
>         continue;
>       }
>       ++p;
>       is_new = 1;
>       for (int i = 0; i < n; ++i) {
>         if (strncmp(p, seen[i], sizeof(seen[i])) == 0) {
>           is_new = 0;
>           break;
>         }
>       }
>       if (is_new) {
>         printf("%s %s map: %s", cxt, dir, p);
>         if (n < 128) {
>           strncpy(seen[n], p, sizeof(seen[n]));
>           seen[n][sizeof(seen[n]) - 1] = '\0';
>           ++n;
>         }
>       }
>     }
>     fclose(fp);
>   }
> }
>
> void* thread_main(void* _) {
>   char buf[1024];
>
>   print_info("Child", "/proc/thread-self");
>
>   snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(),
> main_thread_tid);
>   print_info("Child", buf);
>
>   snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(), (long)
> gettid());
>   print_info("Child", buf);
>
>   return NULL;
> }
>
> int main() {
>   char buf[1024];
>   pthread_t thread;
>   int ret;
>
>   print_info("Main", "/proc/thread-self");
>   print_info("Main", "/proc/self");
>
>   snprintf(buf, sizeof(buf), "/proc/%ld", (long) getpid());
>   print_info("Main", buf);
>
>   main_thread_tid = gettid();
>   snprintf(buf, sizeof(buf), "/proc/self/task/%ld", main_thread_tid);
>   print_info("Main", buf);
>
>   snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(),
> main_thread_tid);
>   print_info("Main", buf);
>
>   if ((ret = pthread_create(&thread, NULL, &thread_main, NULL)) < 0) {
>     printf("ptherad_create failed: %s (%d)\n", strerror(ret), ret);
>   }
>
>   pthread_join(thread, NULL);
>   return 0;
> }
>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..73fe82bcc7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6968,17 +6968,57 @@ static int open_self_auxv(void *cpu_env, int fd)
>      return 0;
>  }
>
> +static int consume_task_directories(const char **filename)
> +{
> +    if (!strncmp(*filename, "task/", strlen("task/"))) {
> +        *filename += strlen("task/");
> +        if (**filename < '1' || **filename > '9') {
> +            return 0;
> +        }
> +        /*
> +         * Don't care about the exact tid.
> +         * XXX: this allows opening files under /proc/self|<pid>/task/<n>
> where
> +         *      <n> is not a valid thread id. Consider checking if the
> file
> +         *      actually exists.
> +         */
> +        const char *p = *filename + 1;
> +        while (*p >= '0' && *p <= '9') {
> +            ++p;
> +        }
> +        if (*p == '/') {
> +            *filename = p + 1;
> +            return 1;
> +        } else {
> +            return 0;
> +        }
> +    }
> +    return 1;
> +}
> +
> +/*
> + * Determines if filename refer to a procfs file for the current process
> or any
> + * thread within the current process. This function should only be used
> to check
> + * for files that have identical contents in all threads, e.g. exec,
> maps, etc.
> + */
>  static int is_proc_myself(const char *filename, const char *entry)
>  {
>      if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
>          filename += strlen("/proc/");
>          if (!strncmp(filename, "self/", strlen("self/"))) {
>              filename += strlen("self/");
> +            if (!consume_task_directories(&filename)) {
> +                return 0;
> +            }
> +        } else if (!strncmp(filename, "thread-self/",
> strlen("thread-self/"))) {
> +            filename += strlen("thread-self/");
>          } else if (*filename >= '1' && *filename <= '9') {
>              char myself[80];
>              snprintf(myself, sizeof(myself), "%d/", getpid());
>              if (!strncmp(filename, myself, strlen(myself))) {
>                  filename += strlen(myself);
> +                if (!consume_task_directories(&filename)) {
> +                    return 0;
> +                }
>              } else {
>                  return 0;
>              }
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
>

--000000000000becfdf0591e6f27c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS4QYJKoZIhvcNAQcCoIIS0jCCEs4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBHMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
--000000000000becfdf0591e6f27c--

