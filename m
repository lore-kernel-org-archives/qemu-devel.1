Received: from eggs.gnu.org ([2001:4830:134:3::10]:33152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz4Ts-0008HG-O4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz4Tp-0006TR-LW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz4Tp-0006Su-D2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35FD85275A
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 17:26:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
	<1505295366-25295-2-git-send-email-peterx@redhat.com>
Date: Mon, 02 Oct 2017 19:25:58 +0200
In-Reply-To: <1505295366-25295-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 13 Sep 2017 17:36:03 +0800")
Message-ID: <87bmlp1mxl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] libqtest: add qmp_device_del()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Peter Xu <peterx@redhat.com> writes:

> Device deletion is tricky since we'll get both a response and an event,
> while the order of arrival may vary.  Provide a helper to handle this
> complexity.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/libqtest.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.h |  8 ++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index b9a1f18..a34d8c4 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -925,6 +925,54 @@ QDict *qmp(const char *fmt, ...)
>      return response;
>  }
>  
> +void qmp_device_del(const char *id)
> +{
> +    QDict *response1, *response2, *event = NULL;
> +    char *cmd;
> +
> +    /*
> +     * device deletion will get one response and one event. E.g.:
> +     *
> +     * {'execute': 'device_del','arguments': { 'id': 'scsi-hd'}}
> +     *
> +     * will get this one:
> +     *
> +     * {"timestamp": {"seconds": 1505289667, "microseconds": 569862},
> +     *  "event": "DEVICE_DELETED", "data": {"device": "scsi-hd",
> +     *  "path": "/machine/peripheral/scsi-hd"}}
> +     *
> +     * and this one:
> +     *
> +     * {"return": {}}
> +     *
> +     * But the order of arrival may vary.  Detect both.
> +     */
> +
> +    cmd = g_strdup_printf("{'execute': 'device_del',"
> +                          " 'arguments': {"
> +                          "   'id': '%s'"
> +                          "}}", id);
> +    response1 = qmp(cmd);
> +    g_free(cmd);
> +    g_assert(response1);
> +    g_assert(!qdict_haskey(response1, "error"));
> +
> +    response2 = qmp("");
> +    g_assert(response2);
> +    g_assert(!qdict_haskey(response2, "error"));

qmp_receive() would be cleaner than qmp("").

> +
> +    if (qdict_haskey(response1, "event")) {
> +        event = response1;
> +    } else if (qdict_haskey(response2, "event")) {
> +        event = response2;
> +    }
> +    g_assert(event);
> +    g_assert(!strcmp(qdict_get_str(event, "event"), "DEVICE_DELETED"));
> +
> +    QDECREF(response1);
> +    QDECREF(response2);
> +}
> +

Uh, this looks similar to existing qtest_qmp_device_del().  Do we need both?

>  void qmp_async(const char *fmt, ...)
>  {
>      va_list ap;
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 3ae5709..0d48e4b 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -920,6 +920,14 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
>  QDict *qmp_fd(int fd, const char *fmt, ...);
>  
>  /**
> + * qmp_device_del:
> + * @id: The device ID to be deleted
> + *
> + * Delete the device with ID @id from QMP interface.
> + */
> +void qmp_device_del(const char *id);
> +
> +/**
>   * qtest_cb_for_every_machine:
>   * @cb: Pointer to the callback function
>   *
