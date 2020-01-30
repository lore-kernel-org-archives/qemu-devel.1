Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7E420708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsyctXxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7E420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixITg-0007bg-Pb
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixISX-0006zc-JD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixISW-00075B-Ar
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:38:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixISW-00074n-7N
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580423927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83QMvUhXNDJgU/JArnI9DfZblcM3I/GwHCM/l1st/+8=;
 b=ZsyctXxG1nkP50DWwK1pSdyJQfrfUTFha3Uu7HqcmjMmDQisEMY739VMM78sGpzq716kgQ
 Id6W0kJG6vSqqVW6cRUUrreNVLAxcvzCYSZBys93pAL75n98hRY2b5d68HHiA0aOySQoGd
 y3Qw0zZH7s/a9cV6St+MQDxZgfZRkTI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-60C8Dp8ZNVi-I7qbnCDwWQ-1; Thu, 30 Jan 2020 17:38:44 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so2379845wro.14
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LGyQwT6SD7w6ml6uMAcQs0U2WDXjJ7jTRLSsOatgTTE=;
 b=O6zwf9Ip6ZhAAgd9fhE3AjalFq64hQRVCT2rpBVDIjOQ8YCByVmora79lvhqKNmHw7
 vZW56HCMMEBQLYJ+wxeT3N39LIkoYbJwAN/vw+pgBq6NUfG6szWUd1bhhDVAF+FnrdGd
 KCukFMXsGdqYYAEsfdb7HKqFAAiQtKHLm9PKMs65fZ+oXPR1rAqQf/1sTyrjoWzp0WrV
 zwYZ05MhKKzMWNIBsZKq1z3dztCJKDJgvVcSzzeHsZv4j24SlEZadtl96+9AO+ebL3iA
 grzAE2k3v0nJ7Ag5itebz4jGeArsbcIoOFuEoHli6q4QEMj9Q1anyKZW8ByQxMux3F+n
 2F8Q==
X-Gm-Message-State: APjAAAX0jtuHl2fVkv13+HEraBsOU8C7Q/IBBi5O4LRp2eirOhgPqIVi
 Nyprk32L48vFwStEvUdztET1S1h5WhsVHkmmzy9kijHm/FkuFju7PTm829JfGU4emw8qMy/3txU
 ppP1oGcQWvho5d2w=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr8456628wmk.68.1580423922742; 
 Thu, 30 Jan 2020 14:38:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt+82kmI+4Yxat/LwAZWePBU47xrWXypjfSYmOfWT26v68nAd3ALD1LDGiGJo5dmGF+xkXuw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr8456606wmk.68.1580423922401; 
 Thu, 30 Jan 2020 14:38:42 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 205sm8268692wmd.42.2020.01.30.14.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:38:41 -0800 (PST)
Subject: Re: [PATCH 2/5] python/qemu: Delint the qmp module
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <20191227134101.244496-3-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d037eb84-3848-23e9-d486-95904371cda6@redhat.com>
Date: Thu, 30 Jan 2020 23:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227134101.244496-3-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 60C8Dp8ZNVi-I7qbnCDwWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/27/19 2:40 PM, Wainer dos Santos Moschetta wrote:
> This clean up the pylint-3 report on qmp:
>=20
> ************* Module qemu.qmp
> python/qemu/qmp.py:1:0: C0111: Missing module docstring (missing-docstrin=
g)
> python/qemu/qmp.py:17:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:21:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:25:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:29:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:33:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:33:0: R0205: Class 'QEMUMonitorProtocol' inherits from=
 object, can be safely removed from bases in python3 (useless-object-inheri=
tance)
> python/qemu/qmp.py:80:4: R1710: Either all return statements in a functio=
n should return an expression, or none of them should. (inconsistent-return=
-statements)
> python/qemu/qmp.py:131:4: R1710: Either all return statements in a functi=
on should return an expression, or none of them should. (inconsistent-retur=
n-statements)
> python/qemu/qmp.py:159:4: R1710: Either all return statements in a functi=
on should return an expression, or none of them should. (inconsistent-retur=
n-statements)
> python/qemu/qmp.py:245:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:249:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:252:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:255:4: C0111: Missing method docstring (missing-docstr=
ing)
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   python/qemu/qmp.py | 51 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 41 insertions(+), 10 deletions(-)
>=20
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 8c6c9847d0..f4e04a6683 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -1,5 +1,4 @@
> -# QEMU Monitor Protocol Python class
> -#
> +""" QEMU Monitor Protocol Python class """
>   # Copyright (C) 2009, 2010 Red Hat Inc.
>   #
>   # Authors:
> @@ -15,22 +14,34 @@ import logging
>  =20
>  =20
>   class QMPError(Exception):
> -    pass
> +    """
> +    QMP base exception
> +    """
>  =20
>  =20
>   class QMPConnectError(QMPError):
> -    pass
> +    """
> +    QMP connection exception
> +    """
>  =20
>  =20
>   class QMPCapabilitiesError(QMPError):
> -    pass
> +    """
> +    QMP negotiate capabilities exception
> +    """
>  =20
>  =20
>   class QMPTimeoutError(QMPError):
> -    pass
> +    """
> +    QMP timeout exception
> +    """
>  =20
>  =20
> -class QEMUMonitorProtocol(object):
> +class QEMUMonitorProtocol:
> +    """
> +    Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP) an=
d then
> +    allow to handle commands and events.
> +    """
>  =20
>       #: Logger object for debugging messages
>       logger =3D logging.getLogger('QMP')
> @@ -81,7 +92,7 @@ class QEMUMonitorProtocol(object):
>           while True:
>               data =3D self.__sockfile.readline()
>               if not data:
> -                return
> +                return None
>               resp =3D json.loads(data)
>               if 'event' in resp:
>                   self.logger.debug("<<< %s", resp)
> @@ -132,7 +143,7 @@ class QEMUMonitorProtocol(object):
>           """
>           Connect to the QMP Monitor and perform capabilities negotiation=
.
>  =20
> -        @return QMP greeting dict
> +        @return QMP greeting dict, or None if negotiate is false
>           @raise OSError on socket connection errors
>           @raise QMPConnectError if the greeting is not received
>           @raise QMPCapabilitiesError if fails to negotiate capabilities
> @@ -141,6 +152,7 @@ class QEMUMonitorProtocol(object):
>           self.__sockfile =3D self.__sock.makefile()
>           if negotiate:
>               return self.__negotiate_capabilities()
> +        return None
>  =20
>       def accept(self):
>           """
> @@ -169,7 +181,7 @@ class QEMUMonitorProtocol(object):
>               self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>           except OSError as err:
>               if err.errno =3D=3D errno.EPIPE:
> -                return
> +                return None
>               raise err
>           resp =3D self.__json_read()
>           self.logger.debug("<<< %s", resp)
> @@ -243,14 +255,33 @@ class QEMUMonitorProtocol(object):
>           self.__events =3D []
>  =20
>       def close(self):
> +        """
> +        Close the socket and socket file.
> +        """
>           self.__sock.close()
>           self.__sockfile.close()
>  =20
>       def settimeout(self, timeout):
> +        """
> +        Set the socket timeout.
> +
> +        @param timeout (float): timeout in seconds, or None.
> +        @note This is a wrap around socket.settimeout
> +        """
>           self.__sock.settimeout(timeout)
>  =20
>       def get_sock_fd(self):
> +        """
> +        Get the socket file descriptor.
> +
> +        @return The file descriptor number.
> +        """
>           return self.__sock.fileno()
>  =20
>       def is_scm_available(self):
> +        """
> +        Check if the socket allows for SCM_RIGHTS.
> +
> +        @return True if SCM_RIGHTS is available, otherwise False.
> +        """
>           return self.__sock.family =3D=3D socket.AF_UNIX
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


