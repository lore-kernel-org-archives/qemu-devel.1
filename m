Received: from eggs.gnu.org ([2001:4830:134:3::10]:34739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eIHri-0001ln-RX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eIHre-0000eN-Mh
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:34:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eIHre-0000Vy-Gk
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:34:10 -0500
References: <20171124143206.28833-1-rkagan@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64158eb0-98a0-5d06-7545-cb3a08a3c472@redhat.com>
Date: Fri, 24 Nov 2017 18:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171124143206.28833-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

On 24.11.2017 15:32, Roman Kagan wrote:
> It's going to be useful, in particular, in VMBus code massively using
> uuids aka GUIDs.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  include/qemu/uuid.h |  2 ++
>  tests/test-uuid.c   | 24 ++++++++++++++++++++++++
>  util/uuid.c         |  7 ++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index afe4840296..09489ce5c5 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -48,6 +48,8 @@ void qemu_uuid_generate(QemuUUID *out);
>  
>  int qemu_uuid_is_null(const QemuUUID *uu);
>  
> +int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv);
> +
>  void qemu_uuid_unparse(const QemuUUID *uuid, char *out);
>  
>  char *qemu_uuid_unparse_strdup(const QemuUUID *uuid);
> diff --git a/tests/test-uuid.c b/tests/test-uuid.c
> index d3a2791fd4..c6c8148117 100644
> --- a/tests/test-uuid.c
> +++ b/tests/test-uuid.c
> @@ -116,6 +116,29 @@ static void test_uuid_is_null(void)
>      g_assert_false(qemu_uuid_is_null(&uuid_not_null_2));
>  }
>  
> +static void test_uuid_is_equal(void)
> +{
> +    int i;
> +    QemuUUID uuid;
> +    QemuUUID uuid_null = { };
> +    QemuUUID uuid_not_null = { { {
> +        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
> +        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
> +    } } };
> +    QemuUUID uuid_null_2 = uuid_null;
> +    QemuUUID uuid_not_null_2 = uuid_not_null;
> +
> +    g_assert(qemu_uuid_is_equal(&uuid_null, &uuid_null_2));
> +    g_assert(qemu_uuid_is_equal(&uuid_not_null, &uuid_not_null_2));
> +    g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid_not_null));
> +
> +    for (i = 0; i < 100; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid));
> +        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));

Isn't there a very low chance that the last line triggers by accident?
Or uuid_no_null guaranteed to not match the generated one? In the latter
case, a comment with a short explanation might be helpful here...

 Thomas
