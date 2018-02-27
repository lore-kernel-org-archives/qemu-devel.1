Received: from eggs.gnu.org ([2001:4830:134:3::10]:43549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnV0-0003HX-LZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnUv-0003Bq-VK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:13:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqnUv-0003Bc-PU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:13:21 -0500
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-7-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12a61ea7-2d76-9c3d-21d1-118ff930264c@redhat.com>
Date: Tue, 27 Feb 2018 16:13:20 -0600
MIME-Version: 1.0
In-Reply-To: <1518784641-43151-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/9] tests: extend qmp test with
 pereconfig checks
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

In the subject line: s/pereconfig/preconfig/

> Add permission checks for commands in 'preconfig' state.
> 
> It should work for all targets, but won't work with
> machine 'none' as it's limited to -smp 1 only.
> So use PC machine for testing preconfig and 'runstate'
> parameter.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/qmp-test.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 

>   
> +static bool is_err(QDict *rsp)
> +{
> +    const char *desc = NULL;
> +    QDict *error = qdict_get_qdict(rsp, "error");
> +    if (error) {
> +        desc = qdict_get_try_str(error, "desc");
> +    }
> +    QDECREF(rsp);
> +    return !!desc;

Wait, so this returns false if this was an error but without a valid desc?

> +}
> +
> +static void test_qmp_preconfig(void)
> +{
> +    QDict *rsp, *ret;
> +    QTestState *qs = qtest_startf("-nodefaults -preconfig -smp 2");
> +
> +    /* preconfig state */
> +    /* enabled commands, no error expected  */
> +    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
> +
> +    /* forbidden commands, expected error */
> +    g_assert(is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));

Does introspection show which commands are valid in preconfig state? 
That may be useful information for a client to know.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
