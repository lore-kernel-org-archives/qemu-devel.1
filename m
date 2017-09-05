Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dp8fz-0006Wi-1r
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dp8fu-00009z-Ei
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:39 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dp8fu-00008m-29
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1504541267-36954-7-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-7-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Tue, 05 Sep 2017 09:53:18 +0200
Message-ID: <w51tw0h7f9t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 6/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 04 Sep 2017 06:07:47 PM CEST, Pradeep Jagadeesh wrote:

> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    IOThrottleList *fsdev_list, *info;
> +    fsdev_list = qmp_query_fsdev_io_throttle(&err);
> +
> +    for (info = fsdev_list; info; info = info->next) {
> +        print_fsdev_throttle_config(mon, info->value);
> +    }
> +    qapi_free_IOThrottleList(fsdev_list);
> +}

You're passing an Error to qmp_query_fsdev_io_throttle() but then you
don't handle it. Use hmp_handle_error() as I said in my previous e-mail.

I know that with the current code qmp_query_fsdev_io_throttle() is never
going to fail, but that's no reason to declare an Error and then ignore
it.

Berto
