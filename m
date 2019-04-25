Received: from eggs.gnu.org ([209.51.188.92]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcWa-0007As-CP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcWZ-0008C8-9C
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJcWZ-0008As-2S
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so20923621wrs.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 04:26:42 -0700 (PDT)
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-14-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb84bda8-ed90-6cf7-41cb-f346d52c5e93@redhat.com>
Date: Thu, 25 Apr 2019 13:26:39 +0200
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/13] tests: acpi: print error unable
 to dump ACPI table during rebuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

On 4/25/19 7:34 AM, Igor Mammedov wrote:
> Instead of just asserting print the error that lead to assert first.
> While at it move assert into rebuild branch, which removes reduntant

"redundant"

> check done in case of !rebuild branch is taken (the later is taken
> care of by g_assert_no_error).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index f117461..5a5d036 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -199,11 +199,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                         sdt->aml, ext);
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
> +            if (fd < 0) {
> +                perror(aml_file);
> +            }
> +            g_assert(fd >= 0);
>          } else {
>              fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
>              g_assert_no_error(error);
>          }
> -        g_assert(fd >= 0);
>  
>          ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
>          g_assert(ret == sdt->aml_len);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
