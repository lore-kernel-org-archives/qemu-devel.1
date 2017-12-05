Received: from eggs.gnu.org ([2001:4830:134:3::10]:57339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMJCg-0003PV-7v
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMJCb-00031z-Cf
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:48:30 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:56884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eMJCb-0002ye-5o
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:48:25 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 626128FE4F
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 20:48:15 +0100 (CET)
Date: Tue, 5 Dec 2017 20:48:05 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171205204805.0f854dc8@bahia.lan>
In-Reply-To: <20171205122740.15005-1-lvivier@redhat.com>
References: <20171205122740.15005-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix analyze-migration.py script
 with radix table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue,  5 Dec 2017 13:27:40 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> Since commit 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
> the HTAB migration stream contains a header set to "-1", meaning there
> is no HPT. Teach analyze-migration.py to ignore the section in this case.
> 
> Without this fix, the script fails with a dump from a POWER9 guest:
> 
> Traceback (most recent call last):
>   File "./qemu/scripts/analyze-migration.py", line 602, in <module>
>     dump.read(dump_memory = args.memory)
>   File "./qemu/scripts/analyze-migration.py", line 539, in read
>     section.read()
>   File "./qemu/scripts/analyze-migration.py", line 250, in read
>     self.file.readvar(n_valid * self.HASH_PTE_SIZE_64)
>   File "./qemu/scripts/analyze-migration.py", line 64, in readvar
>     raise Exception("Unexpected end of %s at 0x%x" % (self.filename, self.file.tell()))
> Exception: Unexpected end of migrate.dump at 0x1d4763ba
> 
> Fixes: 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  scripts/analyze-migration.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 14553876a2..88ff4adb30 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -234,6 +234,10 @@ class HTABSection(object):
>  
>          header = self.file.read32()
>  
> +        if (header == -1):
> +            # "no HPT" encoding
> +            return
> +
>          if (header > 0):
>              # First section, just the hash shift
>              return
