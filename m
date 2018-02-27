Received: from eggs.gnu.org ([2001:4830:134:3::10]:45141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnaj-0005iN-V3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnaf-00060q-TG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:19:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqnaf-00060c-Mz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:19:17 -0500
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-10-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e01c1c1f-d18b-62aa-9959-a0eb5ba9ba1a@redhat.com>
Date: Tue, 27 Feb 2018 16:19:16 -0600
MIME-Version: 1.0
In-Reply-To: <1518784641-43151-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] tests: functional tests for QMP
 command set-numa-node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On 02/16/2018 06:37 AM, Igor Mammedov wrote:
>   * start QEMU with 2 unmapped cpus,
>   * while in preconfig state
>      * add 2 numa nodes
>      * assign cpus to them
>   * exit preconfig and in running state check that cpus
>     are mapped correctly.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/numa-test.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
> 
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 68aca9c..11c2842 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -260,6 +260,76 @@ static void aarch64_numa_cpu(const void *data)
>       g_free(cli);
>   }
>   
> +static bool is_err(QDict *response)
> +{
> +    const char *desc = NULL;
> +    QDict *error = qdict_get_qdict(response, "error");
> +    if (error) {
> +        desc = qdict_get_try_str(error, "desc");
> +    }
> +    QDECREF(response);
> +    return !!desc;

Why are we duplicating this helper in more than one .c file?  If it is a 
common task, it should be in a common file for code reuse.  And as 
before, why are you returning false if the reply is an error but merely 
lacked 'desc'?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
