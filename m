Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ciStP-0005y8-De
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ciStL-0001q9-52
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:31:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ciStK-0001px-RL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:31:35 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RLSWjt018824
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:31:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vq9adc60-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:31:33 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 27 Feb 2017 16:31:32 -0500
References: <1488200143-2140-1-git-send-email-armbru@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 27 Feb 2017 22:31:27 +0100
MIME-Version: 1.0
In-Reply-To: <1488200143-2140-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <026524ae-efd1-4a18-6304-10690c10a7ca@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] option: Tweak invalid size error message
 and unbreak iotest 049
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 02/27/2017 01:55 PM, Markus Armbruster wrote:
> Commit 75cdcd1 neglected to update tests/qemu-iotests/049.out, and
> made the error message for negative size worse.  Fix that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  tests/qemu-iotests/049.out | 14 +++++++++-----
>  util/qemu-option.c         |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
> index 4673b67..34e66db 100644
> --- a/tests/qemu-iotests/049.out
> +++ b/tests/qemu-iotests/049.out
> @@ -95,14 +95,14 @@ qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
>  qemu-img: Image size must be less than 8 EiB!
> 
>  qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
> -qemu-img: Parameter 'size' expects a non-negative number below 2^64
> +qemu-img: Value '-1024' is out of range for parameter 'size'
>  qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
> 
>  qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
>  qemu-img: Image size must be less than 8 EiB!
> 
>  qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
> -qemu-img: Parameter 'size' expects a non-negative number below 2^64
> +qemu-img: Value '-1k' is out of range for parameter 'size'
>  qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
> 
>  qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
> @@ -110,15 +110,19 @@ qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes
>  qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
> 
>  qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +qemu-img: Parameter 'size' expects a non-negative number below 2^64
> +Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
> +and exabytes, respectively.
> +qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
> 
>  qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
>  qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
>  qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
> 
>  qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
> -qemu-img: Parameter 'size' expects a size
> -You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and terabytes.
> +qemu-img: Parameter 'size' expects a non-negative number below 2^64
> +Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
> +and exabytes, respectively.
>  qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
> 
>  == Check correct interpretation of suffixes for cluster size ==
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 419f252..5ce1b5c 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -179,7 +179,7 @@ void parse_option_size(const char *name, const char *value,
> 
>      err = qemu_strtosz(value, NULL, &size);
>      if (err == -ERANGE) {
> -        error_setg(errp, "Value '%s' is too large for parameter '%s'",
> +        error_setg(errp, "Value '%s' is out of range for parameter '%s'",
>                     value, name);
>          return;
>      }
> 
