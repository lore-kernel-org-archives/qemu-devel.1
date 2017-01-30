Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYDt6-0001mK-3a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYDt1-0002Wz-2I
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:29:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56227
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cYDt0-0002Sq-TR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:28:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UFSQgI045416
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 10:28:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a7f4a4sk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 10:28:39 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 30 Jan 2017 15:28:37 -0000
References: <20161020132556.67321-1-pasic@linux.vnet.ibm.com>
	<20161020132556.67321-3-pasic@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 16:28:35 +0100
MIME-Version: 1.0
In-Reply-To: <20161020132556.67321-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <b1f6f338-601f-8525-1f1b-cffdbe203453@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: drop unused
 VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Guenther Hutzl <hutzl@linux.vnet.ibm.com>



On 10/20/2016 03:25 PM, Halil Pasic wrote:
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fc29acf..8767e40 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -66,10 +66,10 @@ static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
>                  }
>              }
>              if (size) {
> -                *((void **)base_addr + field->start) = g_malloc(size);
> +                *(void **)base_addr = g_malloc(size);
>              }
>          }
> -        base_addr = *(void **)base_addr + field->start;
> +        base_addr = *(void **)base_addr;
>      }
> 
>      return base_addr;
Hi!

It is been a while, and IMHO this is still broken, and the
VMSTATE_VBUFFER* macros are still only used with the start argument
being zero.

What changed is that with commit 94869d5c ("migration: migrate QTAILQ")
from Jan 19 we have code actually using VMStateDecription.start -- but
for something different (IMHO), as allocation is done by get_qtailq and
not by vmstate_base_addr (as in case of VMSTATE_VBUFFER_ALLOC_UINT32).
Thus I would need to update the commit message and keep the start field
at least.

But before I do so, I would like to ask the maintainers if there is
interest in a change like this?

Regards,
Halil
