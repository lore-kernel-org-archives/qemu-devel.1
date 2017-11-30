Received: from eggs.gnu.org ([2001:4830:134:3::10]:60738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKQGt-0003Xd-Cl
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKQGp-0003aX-Dd
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:57:03 -0500
Date: Thu, 30 Nov 2017 14:56:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171130145630.GD3952@work-vm>
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130134159.9697-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130134159.9697-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Fix macros with broken
 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> The point of writing a macro embedded in a 'do { ... } while (0)'
> loop is so that the macro can be used as a drop-in statement with
> the caller supplying the trailing ';'.  Although our coding style
> frowns on brace-less 'if':
>   if (cond)
>     statement;
>   else
>     something else;
> the use of do/while (0) in a macro is absolutely essential for the
> purpose of avoiding a syntax error on the 'else' - but it only works
> if there is no trailing ';' in the macro (as the ';' in the code
> calling the macro would then be a second statement and cause the
> 'else' to not pair to the 'if').
> 
> Many of the places touched in this code are examples of the ugly
> bit-rotting debug print statements; cleaning those up is left as
> a bite-sized task for another day.
> 
> Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> diff --git a/migration/rdma.c b/migration/rdma.c
> index ca56594328..9d5a424011 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -88,7 +88,7 @@ static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
>              } \
>              return rdma->error_state; \
>          } \
> -    } while (0);
> +    } while (0)

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
