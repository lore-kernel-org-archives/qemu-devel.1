Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCCC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEB720753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFUwo6H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEB720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFlY-0006WL-8c
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFkq-0005v2-Lo
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFkp-0000Vl-9y
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:01:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jNFkp-0000Ub-3L
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:00:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so5088961wrm.13
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Isly0kRfK8PoyVFmcKHqJrhHAuzEPsUlBvhsJb8HWes=;
 b=RFUwo6H9ISO3VF8euO5xVf1kZtMOC8B7ZfVeX2XO4TRwFAALuxn2Is/VSoY3di17ki
 vj3Pgdne0t8PsKccLStcHGkk+BgetFWe1w96qUY7gQkuwEkfNlnxFxkIrzbmY8OKw/N7
 l5wrrP3ZPDgujjXmYI/iO+2QGXX5VmT3P2FSsOVpXZjZSKCmdrHRWx8tp1KmXdC1VdPh
 CJRf8kmHTs9NBIWzqrNZeMSolKMvXQvgIxVnKeSAsaTK0ckvDNOO8hwoRWrZ8Bb0eEkw
 hTASZDxQVuf1DBREEK8d8LX4DGH4m1cm562XfirZz8QVGX/LfuoV04486aXXymJqaejH
 THIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Isly0kRfK8PoyVFmcKHqJrhHAuzEPsUlBvhsJb8HWes=;
 b=oqqDWCp61bapWVkYthjDOQku2cnq+gXgb6JpvVOeVnTHHYZ/ZCu2AEsWrzo4lE03Md
 UGivnchfF2Hi6QaK00iVjXwXbNPvdsyNEuPKc6zgwPcqXr4q3aySWjfOMaQM0l+QCcYS
 7gzICh25MrStq7X1NZxylRYFiKKwzpiF3WrTsokAK9JVqnrEI69hNoU4ut2XSbU6G4vB
 UyxsFmy8XJHh77rOh8JbPc2qSmijACLSZJNLQ0nZMjoEAZbzw3s6GFokrdKvvD7Xtbar
 UyoIJQp1rV51TeaHQyubHYOqK2Ci14EvIjuVMdhJogT/K7p69LgIFEIQun46E5TfoRjS
 3yLA==
X-Gm-Message-State: AGi0PuY99wRfi4N7RC8zun9WowSBDpM11yDJvWxD7fcp9azzQC9LVtAZ
 ScKDb7ZAFOuGegabz7LvBMSVLQ==
X-Google-Smtp-Source: APiQypJ/3T+y603RUxWOEhJZTNCVFK85QHonjMzTQ+lxB4wHzN5c1V+Y52N8Vn99yB5ywaIHR5gUaA==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr4078173wrw.277.1586610057457; 
 Sat, 11 Apr 2020 06:00:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f3sm6843735wmj.24.2020.04.11.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 06:00:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F9E21FF7E;
 Sat, 11 Apr 2020 14:00:55 +0100 (BST)
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
 <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
 <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
 <5ffb4cc2-f397-28b1-ec63-eb9d606439cf@inria.fr>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
In-reply-to: <5ffb4cc2-f397-28b1-ec63-eb9d606439cf@inria.fr>
Date: Sat, 11 Apr 2020 14:00:55 +0100
Message-ID: <87r1wu89dk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Ludovic Courtes <ludovic.courtes@inria.fr>,
 Riku Voipio <riku.voipio@iki.fi>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Brice Goglin <Brice.Goglin@inria.fr> writes:

> Le 10/04/2020 =C3=A0 14:33, Alex Benn=C3=A9e a =C3=A9crit :
>> That was by inspection on my system which seems to truncate a lot
>> earlier. It would be nice to find where in the Linux kernel it is
>> output but I failed to grep the relevant function last night.
>
>
> It's in proc/array.c, do_task_stat() calls proc_task_name(). In the end,
> it seems to use task->tcomm or task->comm which is limited by
>
> #define TASK_COMM_LEN			16

Thanks. I'll amend the commit message. Are you happy with the fix on
your end?

>
> Brice
>
>
>
>>
>> On Fri, 10 Apr 2020, 12:11 Philippe Mathieu-Daud=C3=A9, <philmd@redhat.c=
om
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     Cc'ing Ludovic in case he can test with Guix-HPC.
>>
>>     On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
>>     > In the original bug report long files names in Guix caused
>>     > /proc/self/stat be truncated without the trailing ") " as
>>     specified in
>>     > proc manpage which says:
>>     >      (2) comm  %s
>>     >             The  filename of the executable, in parentheses.  This
>>     >             is visible whether or not the  executable  is  swapped
>>     >             out.
>>     >
>>     > Additionally it should only be reporting the executable name rather
>>     > than the full path. Fix both these failings while cleaning up
>>     the code
>>     > to use GString to build up the reported values. As the whole
>>     function
>>     > is cleaned up also adjust the white space to the current coding
>>     style.
>>     >
>>     > Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr
>>     <mailto:fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>>
>>     > Reported-by: Brice Goglin <Brice.Goglin@inria.fr
>>     <mailto:Brice.Goglin@inria.fr>>
>>     > Cc: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com
>>     <mailto:philmd@redhat.com>>
>>     > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
>>     <mailto:alex.bennee@linaro.org>>
>>     > ---
>>     >   linux-user/syscall.c | 43
>>     +++++++++++++++++++------------------------
>>     >   1 file changed, 19 insertions(+), 24 deletions(-)
>>     >
>>     > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>     > index 6495ddc4cda..674f70e70a5 100644
>>     > --- a/linux-user/syscall.c
>>     > +++ b/linux-user/syscall.c
>>     > @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env,
>>     int fd)
>>     >   {
>>     >       CPUState *cpu =3D env_cpu((CPUArchState *)cpu_env);
>>     >       TaskState *ts =3D cpu->opaque;
>>     > -    abi_ulong start_stack =3D ts->info->start_stack;
>>     > +    g_autoptr(GString) buf =3D g_string_new(NULL);
>>     >       int i;
>>     >=20=20=20
>>     >       for (i =3D 0; i < 44; i++) {
>>     > -      char buf[128];
>>     > -      int len;
>>     > -      uint64_t val =3D 0;
>>     > -
>>     > -      if (i =3D=3D 0) {
>>     > -        /* pid */
>>     > -        val =3D getpid();
>>     > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>     > -      } else if (i =3D=3D 1) {
>>     > -        /* app name */
>>     > -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>     > -      } else if (i =3D=3D 27) {
>>     > -        /* stack bottom */
>>     > -        val =3D start_stack;
>>     > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>     > -      } else {
>>     > -        /* for the rest, there is MasterCard */
>>     > -        snprintf(buf, sizeof(buf), "0%c", i =3D=3D 43 ? '\n' : ' =
');
>>     > -      }
>>     > +        if (i =3D=3D 0) {
>>     > +            /* pid */
>>     > +            g_string_printf(buf, FMT_pid " ", getpid());
>>     > +        } else if (i =3D=3D 1) {
>>     > +            /* app name */
>>     > +            gchar *bin =3D g_strrstr(ts->bprm->argv[0], "/");
>>     > +            bin =3D bin ? bin + 1 : ts->bprm->argv[0];
>>     > +            g_string_printf(buf, "(%.15s) ", bin);
>>
>>     15 or 125? 15 seems short. From your previous test I understood it
>>     was
>>     124, for
>>     sizeof("cat_with9_12345678901234567890123456789012345678901234567890=
123456789012345678901234567890123456789012345678901234567890___40").
>>
>>     > +        } else if (i =3D=3D 27) {
>>     > +            /* stack bottom */
>>     > +            g_string_printf(buf, TARGET_ABI_FMT_ld " ",
>>     ts->info->start_stack);
>>     > +        } else {
>>     > +            /* for the rest, there is MasterCard */
>>     > +            g_string_printf(buf, "0%c", i =3D=3D 43 ? '\n' : ' ');
>>     > +        }
>>     >=20=20=20
>>     > -      len =3D strlen(buf);
>>     > -      if (write(fd, buf, len) !=3D len) {
>>     > -          return -1;
>>     > -      }
>>     > +        if (write(fd, buf->str, buf->len) !=3D buf->len) {
>>     > +            return -1;
>>     > +        }
>>     >       }
>>     >=20=20=20
>>     >       return 0;
>>     >
>>


--=20
Alex Benn=C3=A9e

