Received: from eggs.gnu.org ([2001:4830:134:3::10]:38288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMjTo-0001wX-UY
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMjTi-0002XJ-H6
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gMjTh-0002Wu-Gt
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:56:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3E1307EA8A
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 00:56:20 +0000 (UTC)
References: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
	<1542121904-17330-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d7308f9e-e68c-ea92-566a-1471ce9848e2@redhat.com>
Date: Tue, 13 Nov 2018 19:56:18 -0500
MIME-Version: 1.0
In-Reply-To: <1542121904-17330-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 11/13/18 10:11 AM, Thomas Huth wrote:
> Once a test has finished, the pcibus structure should be freed, to
> avoid leaking memory and to make sure that the structure is properly
> re-initialized when the next test starts.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/ide-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index 33cef61..f0280e6 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -142,6 +142,10 @@ static void ide_test_start(const char *cmdline_fmt, ...)
>  
>  static void ide_test_quit(void)
>  {
> +    if (pcibus) {
> +        qpci_free_pc(pcibus);
> +        pcibus = NULL;
> +    }
>      pc_alloc_uninit(guest_malloc);
>      guest_malloc = NULL;
>      qtest_end();
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks; I have nothing else queued at the moment, someone else can take
this for now if convenient -- or if I'm being too lazy, let me know and
I'll stage this.

Thanks.
