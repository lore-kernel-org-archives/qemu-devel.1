Received: from eggs.gnu.org ([2001:4830:134:3::10]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQ8i-0000YN-Gd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQ8g-0000dr-AX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:13:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQ8g-0000dY-45
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C62964023ECC
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:13:21 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-3-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96821c07-7aa6-5920-8921-da967258c0d5@redhat.com>
Date: Wed, 22 Aug 2018 12:13:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] check: Use land/lor when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-08-22 11:54, Juan Quintela wrote:
> So everythig is (a bit) more consistent
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
[...]
> @@ -299,9 +297,7 @@ check-qtest-i386-y += tests/q35-test$(EXESUF)
>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>  gcov-files-i386-y += hw/pci-host/q35.c
>  check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
> -ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
> -check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
> -endif
> +check-qtest-x86_64-$(call lor, $(CONFIG_VHOST_USER_NET_TEST_i386), $(CONFIG_VHOST_USER_NET_TEST_x86_64)) += tests/vhost-user-test$(EXESUF)

I think that is the wrong condition. It's rather "!i386 AND x86_64" that
you have to test here. Since that line will get incredibly long with the
$(call ...) expressions, I'd suggest to rather drop this hunk, I think
it's more readable the way it is.

 Thomas
