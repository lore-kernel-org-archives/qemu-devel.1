Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnNYT-00016W-Am
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnNYP-0007RU-CD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnNYP-0007RN-5X
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:50:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170309132216.23482-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 9 Mar 2017 13:22:16 +0000")
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Mar 2017 11:50:14 +0100
Message-ID: <8760jdh2mx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] postcopy: Check for shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com, pasic@linux.vnet.ibm.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Postcopy doesn't support migration of RAM shared with another process
> yet (we've got a bunch of things to understand).
> Check for the case and don't allow postcopy to be enabled.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index effbeb6..dc80dbb 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -95,6 +95,19 @@ static bool ufd_version_check(int ufd)
>      return true;
>  }
>  
> +/* Callback from postcopy_ram_supported_by_host block iterator.
> + */
> +static int test_range_shared(const char *block_name, void *host_addr,
> +                             ram_addr_t offset, ram_addr_t length, void *opaque)


Direct question for the name?

ram_range_is_shared?



> +{
> +    if (qemu_ram_is_shared(qemu_ram_block_by_name(block_name))) {
> +        error_report("Postcopy on shared RAM (%s) is not yet supported",
> +                     block_name);
> +        return 1;
> +    }
> +    return 0;
> +}

Wow, we still predate use of bool for questions :-p


> +
>  /*
>   * Note: This has the side effect of munlock'ing all of RAM, that's
>   * normally fine since if the postcopy succeeds it gets turned back on at the
> @@ -127,6 +140,11 @@ bool postcopy_ram_supported_by_host(void)
>          goto out;
>      }
>  
> +    /* We don't support postcopy with shared RAM yet */
> +    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
> +        goto out;
> +    }
> +
>      /*
>       * userfault and mlock don't go together; we'll put it back later if
>       * it was enabled.

As my comments are only aestetic,

Reviewed-by: Juan Quintela <quintela@redhat.com>
