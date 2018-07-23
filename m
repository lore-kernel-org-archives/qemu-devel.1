Received: from eggs.gnu.org ([2001:4830:134:3::10]:42129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhaFt-000332-Jb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhaFq-0003Za-DW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:48:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhaFq-0003ZU-8V
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:47:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
Date: Mon, 23 Jul 2018 14:47:55 +0200
In-Reply-To: <20180720130928.6696-1-liujunjie23@huawei.com> (liujunjie's
	message of "Fri, 20 Jul 2018 21:09:28 +0800")
Message-ID: <87h8kq86f8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liujunjie <liujunjie23@huawei.com>
Cc: wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org

liujunjie <liujunjie23@huawei.com> writes:

> From: l00425170 <liujunjie23@huawei.com>
>
> The incoming parameters "start" and "end" is int type in
> qstring_from_substr(), but this function can be called by
> qstring_from_str, which is size_t type in strlen(str).

Yes, there's a conversion from size_t to int in

    return qstring_from_substr(str, 0, strlen(str) - 1);

The conversion truncates when strlen(str) - 1 exceeds INT_MAX.

strlen(str) - 1 wraps around to SIZE_MAX when @str is empty.

> It may result in coredump when called g_malloc later.
> One scene to triger is to call hmp "into tlb", which may have
> too long length of string.

Really?  How exactly can this happen?  Please explain step by step.

Aside: @end is only used as @end + 1, and all callers pass some X - 1.
Both the addition and the subtraction can overflow.  Changing the
function to take the index behind the last character instead of the
index of the last character would almost certainly simplify things.  Not
this patch's problem.

>
> Signed-off-by: l00425170 <liujunjie23@huawei.com>
> ---
>  include/qapi/qmp/qstring.h | 2 +-
>  qobject/qstring.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
> index b3b3d44..3e83e3a 100644
> --- a/include/qapi/qmp/qstring.h
> +++ b/include/qapi/qmp/qstring.h
> @@ -24,7 +24,7 @@ struct QString {
>  
>  QString *qstring_new(void);
>  QString *qstring_from_str(const char *str);
> -QString *qstring_from_substr(const char *str, int start, int end);
> +QString *qstring_from_substr(const char *str, size_t start, size_t end);
>  size_t qstring_get_length(const QString *qstring);
>  const char *qstring_get_str(const QString *qstring);
>  const char *qstring_get_try_str(const QString *qstring);
> diff --git a/qobject/qstring.c b/qobject/qstring.c
> index afca54b..18b8eb8 100644
> --- a/qobject/qstring.c
> +++ b/qobject/qstring.c
> @@ -37,7 +37,7 @@ size_t qstring_get_length(const QString *qstring)
>   *
>   * Return string reference
>   */
> -QString *qstring_from_substr(const char *str, int start, int end)
> +QString *qstring_from_substr(const char *str, size_t start, size_t end)
>  {
>      QString *qstring;

The patch makes sense, but the commit message makes claims that need to
be substantiated.
