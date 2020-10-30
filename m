Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4DEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1EC2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHpxnWY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1EC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVM1-000256-Kc
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYVAv-0006KY-8Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYVAq-0007XF-7M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hjXnLS0llySrakhFTMGmdsVpIt5plQrK05hmL1hFUM=;
 b=VHpxnWY5I3QlZmf2jeR/iQctxge4mjLYeI7O/sudmeKRviuxvOpISlTAlaht+lTHOQhl8z
 cgoro1XAxYJca2yLj6oIG2IlQCMSCgNym1SGe6eRqOkFpIsl2TcPUwSRbp4XZ+lJtY+Dpb
 gHVW1+DH9A+/iyHJRhe0oTvx+/f+q3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-O800FgzUMyeiArno5TZ0zw-1; Fri, 30 Oct 2020 10:14:33 -0400
X-MC-Unique: O800FgzUMyeiArno5TZ0zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5590F10A0B89;
 Fri, 30 Oct 2020 14:14:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4162955766;
 Fri, 30 Oct 2020 14:14:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD892113865F; Fri, 30 Oct 2020 15:14:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 06/11] test-util-sockets: Test the complete abstract
 socket matrix
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-7-armbru@redhat.com>
 <20201030093312.GE99222@redhat.com>
Date: Fri, 30 Oct 2020 15:14:23 +0100
In-Reply-To: <20201030093312.GE99222@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Fri, 30 Oct 2020 09:33:12 +0000")
Message-ID: <87d00zssw0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, zxq_yx_007@163.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 29, 2020 at 02:38:28PM +0100, Markus Armbruster wrote:
>> The test covers only two out of nine combinations.  Test all nine.
>> Four turn out to be broken.  Marked /* BUG */.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-util-sockets.c | 86 ++++++++++++++++++++++++++++-----------
>>  1 file changed, 63 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
>> index c2802f69ee..f8b6586e70 100644
>> --- a/tests/test-util-sockets.c
>> +++ b/tests/test-util-sockets.c
>> @@ -230,59 +230,99 @@ static void test_socket_fd_pass_num_nocli(void)
>>  #endif
>> =20
>>  #ifdef __linux__
>> +
>> +#define ABSTRACT_SOCKET_VARIANTS 3
>> +
>> +typedef struct {
>> +    SocketAddress *server, *client[ABSTRACT_SOCKET_VARIANTS];
>> +    bool expect_connect[ABSTRACT_SOCKET_VARIANTS];
>> +} abstract_socket_matrix_row;
>
> snip
>
>> =20
>> -static void test_socket_unix_abstract_good(void)
>> +static void test_socket_unix_abstract(void)
>>  {
>> -    SocketAddress addr;
>> +    SocketAddress addr, addr_tight, addr_padded;
>> +    abstract_socket_matrix_row matrix[ABSTRACT_SOCKET_VARIANTS] =3D {
>> +        { &addr,
>> +          { &addr_tight, &addr_padded, &addr },
>> +          { false /* BUG */, true /* BUG */, true } },
>> +        { &addr_tight,
>> +          { &addr_padded, &addr, &addr_tight },
>> +          { false, false /* BUG */, true } },
>> +        { &addr_padded,
>> +          { &addr, &addr_tight, &addr_padded },
>> +          { true /* BUG */, false, true } }
>> +    };
>
> This is overloading multiple separate tests in one, which is bad for
> test result reporting.
>
>
>> @@ -329,8 +369,8 @@ int main(int argc, char **argv)
>>      }
>> =20
>>  #ifdef __linux__
>> -    g_test_add_func("/util/socket/unix-abstract/good",
>> -                    test_socket_unix_abstract_good);
>> +    g_test_add_func("/util/socket/unix-abstract",
>> +                    test_socket_unix_abstract);
>
> We should instead be registering multiple test funcs, passing in
> param to say which scenario to test.  This ensures we still see
> the test name reflecting which scenario is being run.

There are hundreds of such test functions in tests/ just waiting for you
to create them ;)

Back to serious.  Before the patch, one test function tested two
scenarios.  The patch adds the missing seven.  Feel free to improve on
top.


