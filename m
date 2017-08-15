Received: from eggs.gnu.org ([2001:4830:134:3::10]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWCm-00050h-GF
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWCi-0000Rl-Fk
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhWCi-0000RM-8d
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:23:56 -0400
Date: Tue, 15 Aug 2017 09:23:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815092350.1dd6c484.cohuck@redhat.com>
In-Reply-To: <20170814204450.24118-2-farman@linux.vnet.ibm.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<20170814204450.24118-2-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] pc-bios/s390-ccw: Use rm command
 during make clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: thuth@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On Mon, 14 Aug 2017 22:44:50 +0200
Eric Farman <farman@linux.vnet.ibm.com> wrote:

> This reverts what I think was an accidental change that replaced
> the "rm -f" command with an undefined variable RM, and causes the
> "make clean" command to fail for a s390 target:
> 
> make[1]: Entering directory '/usr/src/qemu/build/pc-bios/s390-ccw'
> rm -f *.timestamp
> *.o *.d *.img *.elf *~ *.a
> /bin/sh: *.o: command not found
> Makefile:39: recipe for target 'clean' failed
> make[1]: *** [clean] Error 127
> make[1]: Leaving directory '/usr/src/qemu/build/pc-bios/s390-ccw'
> Makefile:489: recipe for target 'clean' failed
> make: *** [clean] Error 1
> 
> Fixes: 3e4415a751d2 ("pc-bios/s390-ccw: Add core files for the network
>                       bootloading program")
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index cbae74522a..6d0c2ee691 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -36,4 +36,4 @@ s390-netboot.img:
>  endif
>  
>  clean:
> -	$(RM) *.o *.d *.img *.elf *~ *.a
> +	rm -f *.o *.d *.img *.elf *~ *.a

Thanks, applied with a tweaked commit message:

pc-bios/s390-ccw: Use rm command during make clean
    
This reverts a change that replaced the "rm -f" command with the
undefined variable RM (expected to be set by make), and causes the
"make clean" command to fail for a s390 target:
(...)
