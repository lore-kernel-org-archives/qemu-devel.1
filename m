Received: from eggs.gnu.org ([209.51.188.92]:42913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4JX-0006C0-7j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4JW-0005sH-4Q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:15:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4JR-0005na-1E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:15:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so2450246wmg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:15:40 -0800 (PST)
References: <20190219114609.1582-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <105f265f-99dd-e4cc-dba9-03ff62aa7521@redhat.com>
Date: Tue, 19 Feb 2019 13:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190219114609.1582-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix error reporting for -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On 2/19/19 12:46 PM, Daniel P. Berrangé wrote:
> Error reporting for user_creatable_add_opts_foreach was changed so that
> it no longer called 'error_report_err' in:
> 
>   commit 7e1e0c11127bde81cff260fc6859690435c509d6
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Wed Oct 17 10:26:43 2018 +0200
> 
>     qom: Clean up error reporting in user_creatable_add_opts_foreach()
> 
> Some callers were updated to pass in "&error_fatal" but all the ones in
> qemu-img were left passing NULL. As a result all errors went to
> /dev/null instead of being reported to the user.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qemu-img.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 25288c4d18..903c37b706 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -503,7 +503,7 @@ static int img_create(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          goto fail;
>      }
>  
> @@ -753,7 +753,7 @@ static int img_check(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -966,7 +966,7 @@ static int img_commit(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -1349,7 +1349,7 @@ static int img_compare(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          ret = 2;
>          goto out4;
>      }
> @@ -2159,7 +2159,7 @@ static int img_convert(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          goto fail_getopt;
>      }
>  
> @@ -2713,7 +2713,7 @@ static int img_info(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -2932,7 +2932,7 @@ static int img_map(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -3081,7 +3081,7 @@ static int img_snapshot(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -3241,7 +3241,7 @@ static int img_rebase(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -3621,7 +3621,7 @@ static int img_resize(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          return 1;
>      }
>  
> @@ -3865,7 +3865,7 @@ static int img_amend(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          ret = -1;
>          goto out_no_progress;
>      }
> @@ -4509,7 +4509,7 @@ static int img_dd(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          ret = -1;
>          goto out;
>      }
> @@ -4786,7 +4786,7 @@ static int img_measure(int argc, char **argv)
>  
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> +                          NULL, &error_fatal)) {
>          goto out;
>      }
>  
> 
