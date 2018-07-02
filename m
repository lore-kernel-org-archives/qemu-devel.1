Received: from eggs.gnu.org ([2001:4830:134:3::10]:32864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa6AS-00059E-QQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa6AO-0007pb-QP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:15:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa6AO-0007p2-Cj
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0793D401EF2E
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 21:15:24 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42a6b4dd-c278-2ca2-1843-61f35968c0ef@redhat.com>
Date: Mon, 2 Jul 2018 16:15:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/32] tests/test-qga: Demonstrate the
 guest-agent ignores "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qga.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 30c9643257..4edd35535d 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -227,6 +227,22 @@ static void test_qga_ping(gconstpointer fix)
>       qobject_unref(ret);
>   }
>   
> +static void test_qga_invalid_id(gconstpointer fix)
> +{
> +    /* FIXME "id" is ignored; it should be rejected */

I might have written:

/* FIXME "id" is ignored; it should either be repeated in the reply, or 
rejected on input */

> +    const TestFixture *fixture = fix;
> +    QDict *ret, *val;
> +
> +    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
> +    g_assert_nonnull(ret);
> +    qmp_assert_no_error(ret);
> +
> +    val = qdict_get_qdict(ret, "return");
> +    g_assert(!qdict_haskey(val, "id"));

This is documenting what currently happens, along with the FIXME showing 
that it is not ideal, so whether or not you improve the comment:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
