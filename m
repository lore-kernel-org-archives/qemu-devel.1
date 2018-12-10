Received: from eggs.gnu.org ([2001:4830:134:3::10]:33115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWU2k-0006Ia-8B
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWU2i-0001uO-Jo
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:28:50 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-5-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f9ed3b5-3881-c50a-49dc-7513b053a99c@redhat.com>
Date: Mon, 10 Dec 2018 16:28:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181130220344.3350618-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

On 11/30/18 4:03 PM, Eric Blake wrote:
> Our open-coding of strtol handling forgot to handle overflow
> conditions. What's more, since we insiste on a user-supplied
> partition to be non-zero, we can use 0 rather than -1 for our
> initial value to distinguish when a partition is not being
> served, for slightly more optimal code.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qemu-nbd.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 55e29bd9a7e..866e64779f1 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -546,7 +546,7 @@ int main(int argc, char **argv)
>       int opt_ind = 0;
>       char *end;
>       int flags = BDRV_O_RDWR;
> -    int partition = -1;
> +    int partition = 0;
>       int ret = 0;
>       bool seen_cache = false;
>       bool seen_discard = false;
> @@ -685,13 +685,9 @@ int main(int argc, char **argv)
>               flags &= ~BDRV_O_RDWR;
>               break;
>           case 'P':
> -            partition = strtol(optarg, &end, 0);
> -            if (*end) {
> -                error_report("Invalid partition `%s'", optarg);
> -                exit(EXIT_FAILURE);
> -            }
> -            if (partition < 1 || partition > 8) {
> -                error_report("Invalid partition %d", partition);
> +            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||

Hmm - the fact that 'char *end' is not a dead variable means there are 
more uses of strtoll() that need fixing. I'll get those in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
