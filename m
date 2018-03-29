Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Tm7-0001BJ-Vc
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Tm4-0002wK-Nm
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:23:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1Tm4-0002w8-KP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EB20EBFF7
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 09:23:12 +0000 (UTC)
Date: Thu, 29 Mar 2018 10:23:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329092308.GA6245@work-vm>
References: <20180321113644.21899-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180321113644.21899-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix pfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Fix leak spotted by ASAN:
>=20
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7fe1abb80a38 in __interceptor_calloc (/lib64/libasan.so.4+0xde=
a38)
>     #1 0x7fe1aaf1bf75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x7fe1aaf1c249 in g_malloc0_n ../glib/gmem.c:355
>     #3 0x55f4841cfaa9 in postcopy_ram_fault_thread /home/elmarco/src/qe=
mu/migration/postcopy-ram.c:596
>     #4 0x55f48479447b in qemu_thread_start /home/elmarco/src/qemu/util/=
qemu-thread-posix.c:504
>     #5 0x7fe1a043550a in start_thread (/lib64/libpthread.so.0+0x750a)
>=20
> Regression introduced with commit 00fa4fc85b00f1a8a810068d158a7a66e8865=
8eb.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued

> ---
>  migration/postcopy-ram.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index efd77939af..4a0b33b373 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -754,6 +754,7 @@ static void *postcopy_ram_fault_thread(void *opaque=
)
>          }
>      }
>      trace_postcopy_ram_fault_thread_exit();
> +    g_free(pfd);
>      return NULL;
>  }
> =20
> --=20
> 2.16.2.521.g9aa15f885a
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
