Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1154C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8B6239CF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdL4mxcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8B6239CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZFm-0006yT-P6
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZED-0005ih-Ov
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:56:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZEB-0007vg-JR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:56:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLnHc2086498;
 Thu, 24 Sep 2020 21:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PO/+MPSFsfrcY8TXay9YRNNGGYNKzkEY3zxqqURHpIg=;
 b=hdL4mxcKd6OD2q63cVb0bZOXCCIZHAYiv/eAXU6ksEMSynusO1Flrv6llUp82tbWqeIg
 mw0bPiCJ8R4x2bKbQQ8+BB9P3rZKJ91CtBZb1v9Crg9UwE/Ndn90C2jcpJfPHKLWKcL7
 Nz0iSNZgk4mBIl7BFpxRSVFfSYJIgiDXUDkRghsuVMpqJirWF4XTaqUZGYlpDCqmcaWu
 khaF6V530GK1OegHxZQ74F/QaROD1bqJT0IXfEivA5fDgS98HqF1ISp38vWqKCFVVvjw
 nGgIk2T7CNQZqemhtTNfBeMc+Ye0ysDTvMSS8gSvs2Tncv+Y+rnzIW+C5N+NaJ45EHxo Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 33q5rgs3k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:56:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoU6n046312;
 Thu, 24 Sep 2020 21:54:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33nurwtsnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:54:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OLsTD7028759;
 Thu, 24 Sep 2020 21:54:30 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:54:29 -0700
Subject: Re: [PATCH V1 22/32] char: qio_channel_socket_accept reuse fd
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-23-git-send-email-steven.sistare@oracle.com>
 <20200915173334.GD2922@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <1fe5d582-52a0-dad1-583f-8b11ffb56ec7@oracle.com>
Date: Thu, 24 Sep 2020 17:54:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915173334.GD2922@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 16:42:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/2020 1:33 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> From: Mark Kanda <mark.kanda@oracle.com>
>>
>> Add an fd argument to qio_channel_socket_accept.  If not -1, the channel
>> uses that fd instead of accepting a new socket connection.  All callers
>> pass -1 in this patch, so no functional change.
> 
> Doesn't some of this just come from the fact you're insisting on reusing
> the command line?   We should be able to open a chardev on an fd
> shouldn't we?

If the management layer originally added the char device via hot plug, then
we expect it to do so again after restart, following the typical practice for
live migration.  The device has no presence on the command line.

- Steve

>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/io/channel-socket.h    |  3 ++-
>>  io/channel-socket.c            | 12 +++++++++---
>>  io/net-listener.c              |  4 ++--
>>  scsi/qemu-pr-helper.c          |  2 +-
>>  tests/qtest/tpm-emu.c          |  2 +-
>>  tests/test-char.c              |  2 +-
>>  tests/test-io-channel-socket.c |  4 ++--
>>  7 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>> index 777ff59..0ffc560 100644
>> --- a/include/io/channel-socket.h
>> +++ b/include/io/channel-socket.h
>> @@ -248,6 +248,7 @@ qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
>>  /**
>>   * qio_channel_socket_accept:
>>   * @ioc: the socket channel object
>> + * @reuse_fd: fd to reuse; -1 otherwise
>>   * @errp: pointer to a NULL-initialized error object
>>   *
>>   * If the socket represents a server, then this accepts
>> @@ -258,7 +259,7 @@ qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
>>   */
>>  QIOChannelSocket *
>>  qio_channel_socket_accept(QIOChannelSocket *ioc,
>> -                          Error **errp);
>> +                          int reuse_fd, Error **errp);
>>  
>>  
>>  #endif /* QIO_CHANNEL_SOCKET_H */
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index e1b4667..dde12bf 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -352,7 +352,7 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
>>  
>>  QIOChannelSocket *
>>  qio_channel_socket_accept(QIOChannelSocket *ioc,
>> -                          Error **errp)
>> +                          int reuse_fd, Error **errp)
>>  {
>>      QIOChannelSocket *cioc;
>>  
>> @@ -362,8 +362,14 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>>  
>>   retry:
>>      trace_qio_channel_socket_accept(ioc);
>> -    cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
>> -                           &cioc->remoteAddrLen);
>> +
>> +    if (reuse_fd != -1) {
>> +        cioc->fd = reuse_fd;
>> +    } else {
>> +        cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
>> +                               &cioc->remoteAddrLen);
>> +    }
>> +
>>      if (cioc->fd < 0) {
>>          if (errno == EINTR) {
>>              goto retry;
>> diff --git a/io/net-listener.c b/io/net-listener.c
>> index 5d8a226..bbdea1e 100644
>> --- a/io/net-listener.c
>> +++ b/io/net-listener.c
>> @@ -45,7 +45,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>>      QIOChannelSocket *sioc;
>>  
>>      sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>> -                                     NULL);
>> +                                     -1, NULL);
>>      if (!sioc) {
>>          return TRUE;
>>      }
>> @@ -194,7 +194,7 @@ static gboolean qio_net_listener_wait_client_func(QIOChannel *ioc,
>>      QIOChannelSocket *sioc;
>>  
>>      sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>> -                                     NULL);
>> +                                     -1, NULL);
>>      if (!sioc) {
>>          return TRUE;
>>      }
>> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
>> index 57ad830..0e6d683 100644
>> --- a/scsi/qemu-pr-helper.c
>> +++ b/scsi/qemu-pr-helper.c
>> @@ -800,7 +800,7 @@ static gboolean accept_client(QIOChannel *ioc, GIOCondition cond, gpointer opaqu
>>      PRHelperClient *prh;
>>  
>>      cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>> -                                     NULL);
>> +                                     -1, NULL);
>>      if (!cioc) {
>>          return TRUE;
>>      }
>> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
>> index 2e8eb7b..19e5dab 100644
>> --- a/tests/qtest/tpm-emu.c
>> +++ b/tests/qtest/tpm-emu.c
>> @@ -83,7 +83,7 @@ void *tpm_emu_ctrl_thread(void *data)
>>      g_cond_signal(&s->data_cond);
>>  
>>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
>> -    ioc = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
>> +    ioc = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>>      g_assert(ioc);
>>  
>>      {
>> diff --git a/tests/test-char.c b/tests/test-char.c
>> index 614bdac..1bb6ae0 100644
>> --- a/tests/test-char.c
>> +++ b/tests/test-char.c
>> @@ -884,7 +884,7 @@ char_socket_client_server_thread(gpointer data)
>>      QIOChannelSocket *cioc;
>>  
>>  retry:
>> -    cioc = qio_channel_socket_accept(ioc, &error_abort);
>> +    cioc = qio_channel_socket_accept(ioc, -1, &error_abort);
>>      g_assert_nonnull(cioc);
>>  
>>      if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) != 0) {
>> diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
>> index d43083a..0d410cf 100644
>> --- a/tests/test-io-channel-socket.c
>> +++ b/tests/test-io-channel-socket.c
>> @@ -75,7 +75,7 @@ static void test_io_channel_setup_sync(SocketAddress *listen_addr,
>>      qio_channel_set_delay(*src, false);
>>  
>>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
>> -    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
>> +    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>>      g_assert(*dst);
>>  
>>      test_io_channel_set_socket_bufs(*src, *dst);
>> @@ -143,7 +143,7 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
>>      g_assert(!data.err);
>>  
>>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
>> -    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
>> +    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>>      g_assert(*dst);
>>  
>>      qio_channel_set_delay(*src, false);
>> -- 
>> 1.8.3.1
>>

