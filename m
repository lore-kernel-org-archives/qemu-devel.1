Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figsy-0002n5-LC
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figsv-0007mH-Kg
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:04:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1figsv-0007lB-F2
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:04:53 -0400
References: <20180726061844.25992-1-armbru@redhat.com>
	<20180726061844.25992-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba393187-cb99-0ed6-e135-05c58ccd975a@redhat.com>
Date: Thu, 26 Jul 2018 09:04:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180726061844.25992-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qstring: Assert size calculations
 don't overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: liujunjie23@huawei.com

On 07/26/2018 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/qstring.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qobject/qstring.c b/qobject/qstring.c
> index 18b8eb82f8..7990569c5a 100644
> --- a/qobject/qstring.c
> +++ b/qobject/qstring.c
> @@ -41,17 +41,19 @@ QString *qstring_from_substr(const char *str, size_t start, size_t end)
>   {
>       QString *qstring;
>   
> +    assert(start <= end + 1);

end + 1 can overflow size_t, but it is unsigned so well-defined, and the 
assert will trigger as desired.

> @@ -68,7 +70,9 @@ QString *qstring_from_str(const char *str)
>   static void capacity_increase(QString *qstring, size_t len)
>   {
>       if (qstring->capacity < (qstring->length + len)) {
> +        assert(len <= SIZE_MAX - qstring->capacity);
>           qstring->capacity += len;

You've asserted that this addition won't overflow...

> +        assert(qstring->capacity + len <= SIZE_MAX / 2);

...but now that qstring->capacity is larger, this could overflow. Do you 
really need the +len in here, given that...

>           qstring->capacity *= 2; /* use exponential growth */

...you are really only trying to prevent overflow of doubling 
qstring->capacity without adding yet another len in the mix?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
