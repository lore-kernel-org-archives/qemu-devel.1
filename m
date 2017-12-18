Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQskX-0007W8-Ku
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQskT-0005DM-0z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:34:21 -0500
References: <20171218100404.4427-1-david@gibson.dropbear.id.au>
	<20171218100404.4427-3-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c791d1f7-d10c-9c8e-70d1-b600125d859f@redhat.com>
Date: Mon, 18 Dec 2017 11:34:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171218100404.4427-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 2/4] tests/pxe-test: Use table of
 testcases rather than open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 18.12.2017 11:04, David Gibson wrote:
> Currently pxe-tests open codes the list of tests for each architecture.
> This changes it to use tables of test parameters, somewhat similar to
> boot-serial-test.
> 
> This adds the machine type into the table as well, giving us the ability
> to perform tests on multiple machine types for architectures where there's
> more than one machine type that matters.
> 
> NOTE: This changes the names of the tests in the output, to include the
>       machine type and IPv4 vs. IPv6.  I'm not sure if this has the
>       potential to break existing tooling.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/pxe-test.c | 87 ++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index eb70aa2bc6..8c310a8129 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -22,14 +22,52 @@
>  
>  static char disk[] = "tests/pxe-test-disk-XXXXXX";
>  
> -static void test_pxe_one(const char *params, bool ipv6)
> +typedef struct testdef {
> +    const char *machine;    /* Machine type */
> +    const char *model;      /* NIC device model */
> +    const char *devopts;    /* Device options */
> +} testdef_t;
[...]
> +static testdef_t s390x_tests[] = {
> +    { "s390-ccw-virtio", "virtio-net-ccw", ",bootindex=1" },
> +    { NULL },
> +};
> +
> +static void test_pxe_one(const testdef_t *test, bool ipv6)
>  {
>      char *args;
>  
> -    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
> -                           "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
> -                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
> -                           ipv6 ? "on" : "off", params);
> +    args = g_strdup_printf(
> +        "-machine %s,accel=kvm:tcg -nodefaults -boot order=n "
> +        "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,ipv4=%s,ipv6=%s "
> +        "-device %s%s,netdev=" NETNAME,
> +        test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",
> +        test->model, test->devopts ? test->devopts : "");

Looking at this again, I think we could also simply always add the
"bootindex=1" to the args string - this should not hurt, rather might
help to boot faster, and then you could get rid of the"devopts" field in
the testdef_t struct.

Anyway, with or without that modification:

Reviewed-by: Thomas Huth <thuth@redhat.com>
