Received: from eggs.gnu.org ([209.51.188.92]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hEehA-0002zc-EW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hEeh9-0005Hc-Go
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:08 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hEeh9-0005CB-7W
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:07 -0400
Date: Thu, 11 Apr 2019 20:45:02 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190411184502.xvesnriqcocyvuan@function>
References: <20190405184648.17029-1-dgilbert@redhat.com>
	<20190405212501.cdg4u3m7ihldcop4@function>
	<20190408084653.GB2687@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408084653.GB2687@work-vm>
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

Hello,

Dr. David Alan Gilbert, le lun. 08 avril 2019 09:46:53 +0100, a ecrit:
> 'soread' has the comment:
> 
>         /*
>          * No need to check if there's enough room to read.
>          * soread wouldn't have been called if there weren't
>          */
>         sopreprbuf(so, iov, &n);
> 
> the compiler doesn't realise that, and is moaning about the case
> where the if (len <=0) return happens and the following 
> code tries to use iov.

I see. Perhaps we should make this an assert then? In case this isn't
true, i.e. soread() is called even if no room is available, returning 0
would probably just let the caller just try again, and we should rather
just plainly crash than hang?

Samuel
