Received: from eggs.gnu.org ([2001:4830:134:3::10]:53438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPO6-0000GY-Sw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPO5-0005yO-UV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:40:10 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <515b39c0-3f38-1ed7-ff1d-210412f4be0e@redhat.com>
Date: Thu, 15 Feb 2018 13:39:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/27] qdict: Introduce qdict_rename_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> A few block drivers will need to rename .bdrv_create options for their
> QAPIfication, so let's have a helper function for that.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qapi/qmp/qdict.h |  6 ++++++
>   qobject/qdict.c          | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)

Again, unit test coverage?

> +/**
> + * qdict_rename_keys(): Rename keys in qdict according to the replacements
> + * specified in the array renames. The array must be terminated by an entry
> + * with from = NULL.
> + *
> + * Returns true for success, false in error cases.
> + */
> +bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
> +{
> +    QObject *qobj;
> +
> +    while (renames->from) {
> +        if (qdict_haskey(qdict, renames->from)) {
> +            if (qdict_haskey(qdict, renames->to)) {

Depending on how efficient qdict_haskey() is, this is a lot of looping. 
Good thing our lists aren't so large that we'd notice the effects of 
cubic scaling (I count O(m*n*n), where m is renames length, and n is 
worst-case performance of qdict_haskey).  Definitely not worth the 
effort of more code to try and have a more efficient algorithm in 
large-term scaling but which hurts performance with increased overhead 
on small lists.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
