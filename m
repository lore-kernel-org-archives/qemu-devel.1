Received: from eggs.gnu.org ([2001:4830:134:3::10]:43415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMb1g-0007ve-4q
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMb1d-0008CT-CF
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:54:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMb1Z-00089c-0c
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A98F3082B4B
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 15:54:41 +0000 (UTC)
References: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
	<1542121904-17330-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a746640-3b7b-ac0b-a214-251a0a2addc0@redhat.com>
Date: Tue, 13 Nov 2018 09:54:33 -0600
MIME-Version: 1.0
In-Reply-To: <1542121904-17330-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 11/13/18 9:11 AM, Thomas Huth wrote:
> Once a test has finished, the pcibus structure should be freed, to
> avoid leaking memory and to make sure that the structure is properly
> re-initialized when the next test starts.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/ide-test.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

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
> +        qpci_free_pc(pcibus);
> +        pcibus = NULL;
> +    }
>       pc_alloc_uninit(guest_malloc);
>       guest_malloc = NULL;
>       qtest_end();
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
