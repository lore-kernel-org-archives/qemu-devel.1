Received: from eggs.gnu.org ([2001:4830:134:3::10]:53100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMbdh-0000O4-JP
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMbdc-00089d-UB
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:34:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMbdc-000896-Nu
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:34:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so12017729wme.3
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 08:34:04 -0800 (PST)
References: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
	<1542121904-17330-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <08b5a780-0e86-58ed-d864-a2cb6d6ae0af@redhat.com>
Date: Tue, 13 Nov 2018 17:34:01 +0100
MIME-Version: 1.0
In-Reply-To: <1542121904-17330-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/ide: Free pcibus when finishing a
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 13/11/18 16:11, Thomas Huth wrote:
> Once a test has finished, the pcibus structure should be freed, to
> avoid leaking memory and to make sure that the structure is properly
> re-initialized when the next test starts.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/ide-test.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index 33cef61..f0280e6 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -142,6 +142,10 @@ static void ide_test_start(const char *cmdline_fmt, ...)
>   
>   static void ide_test_quit(void)
>   {
> +    if (pcibus) {

This check would be cleaner in qpci_free_pc().

> +        qpci_free_pc(pcibus);
> +        pcibus = NULL;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    }
>       pc_alloc_uninit(guest_malloc);
>       guest_malloc = NULL;
>       qtest_end();
> 
