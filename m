Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5282FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C18C205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vmfacility.fr header.i=@vmfacility.fr header.b="GsJ8t/eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=vmfacility.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqVg-0001r0-6d
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ivan@vmfacility.fr>) id 1iHqDL-0002mX-P0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ivan@vmfacility.fr>) id 1iHqDK-0006Bw-1S
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:11:47 -0400
Received: from db04.iswnet.net ([2001:bc8:3515:300::1]:50266
 helo=db04.ivansoftware.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ivan@vmfacility.fr>) id 1iHqDI-00069s-FN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:11:45 -0400
Received: from [IPv6:2a01:cb19:678:2500:7d70:200c:232c:5ea] (unknown
 [IPv6:2a01:cb19:678:2500:7d70:200c:232c:5ea])
 by db04.ivansoftware.com (Postfix) with ESMTPSA id 049D0BE35EF;
 Tue,  8 Oct 2019 16:11:40 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at db04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vmfacility.fr;
 s=mail; t=1570543900;
 bh=lDVRMXnHBDh2JWbrMHWlDcSZbJGfmNsbYtVt3De5I38=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GsJ8t/eReSIs/iZUbRJbeGJBmLUwDforwruEW5gQyZ/YQ3C9NmP9f+69WDUcWHbNa
 rGCgM+2+mN3yCYGMqQdiHh4XjhnHViNqzpAhQfVXvPNMPejscRa5+fRhPsiS4L/wyb
 Inxg1IcDIPdvcIZsnqBt1d2F7k7uFGACtpdGSaRWW+HfbxFgRh5eEQRwttUQGnVGTC
 BCq44ePETj0cyRh19wSgnXzkNPt4Rx/43SvZ5cSOWPjiTqPHWLhkXQcyal34y/Kmxy
 x81603dwr+8WTZnHyEQJ8GglCA6kepgqGoAOsZH+AuRopwG/AJan/82MzGgqzJzS9O
 PK3QlXXQCr+5A==
Subject: Re: [Bug 1847232] [NEW] qemu TCG in s390x mode issue with calculating
 HASH
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Bug 1847232 <1847232@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org
References: <157053356610.22354.6751604707489617887.malonedeb@gac.canonical.com>
 <20191008141135.11f5a065.cohuck@redhat.com>
 <61ce859f-0817-0eba-7eb8-2c16b3e73889@redhat.com>
From: Ivan Warren <ivan@vmfacility.fr>
Message-ID: <7a661e58-72df-94bc-4712-f306ce5ee7c6@vmfacility.fr>
Date: Tue, 8 Oct 2019 16:11:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <61ce859f-0817-0eba-7eb8-2c16b3e73889@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050600060405090406020207"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:3515:300::1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a cryptographically signed message in MIME format.

--------------ms050600060405090406020207
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 10/8/2019 3:35 PM, David Hildenbrand wrote:
> On 08.10.19 14:11, Cornelia Huck wrote:
>> On Tue, 08 Oct 2019 11:19:25 -0000
>> Ivan Warren via <qemu-devel@nongnu.org> wrote:
>>
>>> Public bug reported:
>>>
>>> When using go on s390x on Debian x64 (buster) (host) and debian s390x=

>>> (sid) (guest) I run into the following problem :
>>>
>>> The following occurs while trying to build a custom project :
>>>
>>> go: github.com/FactomProject/basen@v0.0.0-20150613233007-fe3947df716e=
:
>>> Get
>>> https://proxy.golang.org/github.com/%21factom%21project/basen/@v/v0.0=
=2E0-20150613233007-fe3947df716e.mod:
>>> local error: tls: bad record MAC
>>>
>>> Doing a git bisect I find that this problem only occurs on and after
>>> commit 08ef92d556c584c7faf594ff3af46df456276e1b
>>>
>>> Before that commit, all works fine. Past this commit, build always
>>> fails.
>> What version are you using? Current master?
>>
>> Can you please share your command line?
>>
>>> Without any proof, It looks like a hash calculation bug related to us=
ing
>>> z/Arch vector facilities...
>> Not an unreasonable guess, cc:ing David in case he has seen that befor=
e.
>>
> Can you reproduce with "-cpu qemu,vx=3Doff" added to the QEMU command
> line? Could be some fallout from vector instruction support. Currently
> ill, will have a look when I'm feeling better.

Reposted with a reply all... (sorry for the duplicates)

So it does !


My qemu command line is now (forget the odd funny networking things..)

qemu-system-s390x \
 =C2=A0=C2=A0=C2=A0 -drive=20
file=3DDEB002.IMG.NEW,discard=3Dunmap,cache=3Dwriteback,id=3Ddrive-0,if=3D=
none \
 =C2=A0=C2=A0=C2=A0 -device virtio-scsi-ccw,id=3Dvirtio-scsi-0 \
 =C2=A0=C2=A0=C2=A0 -device scsi-hd,id=3Dscsi-hd-0,drive=3Ddrive-0 \
 =C2=A0=C2=A0=C2=A0 -m 8G \
 =C2=A0=C2=A0=C2=A0 -net nic,macaddr=3D52:54:00:00:00:02 \
 =C2=A0=C2=A0=C2=A0 -net tap,ifname=3Dtaparm,script=3Dno \
 =C2=A0=C2=A0=C2=A0 -nographic -accel tcg,thread=3Dmulti \
 =C2=A0=C2=A0=C2=A0 -monitor unix:ms,server,nowait \
 =C2=A0=C2=A0=C2=A0 -cpu qemu,vx=3Doff \=C2=A0 ##### THAT WAS ADDED as in=
structed - without it=20
everything goes kaput !
 =C2=A0=C2=A0=C2=A0 -smp 12

And using the latest bleeding edge qemu from github, my build works (the =

problem goes away).

So the z/Arch vector instructions may have a glitch is a venue to=20
consider.. Probably one that couldn't be screened through conventional=20
methods.

I'm not that versed into z/Arch vector instruction, but if there=20
anything I can help with, I will !

--Ivan




--------------ms050600060405090406020207
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CykwggURMIID+aADAgECAhABSzGLseyYaS5Q+y8WzDO3MA0GCSqGSIb3DQEBCwUAMIGWMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDcwNDAwMDAw
MFoXDTIyMDcwMzIzNTk1OVowIzEhMB8GCSqGSIb3DQEJARYSaXZhbkB2bWZhY2lsaXR5LmZy
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA16J+MNpaqIEV5b2WoLC+l2PP5n3W
CtXrhU04ursB8Ib+TIGaJQQigdKp2pX7xwY9F/h1vukcYHNxILOvpop8AYyFbCMwmh0r2vZs
hDpYA1adv7wGsL3tbV155FTk0RewY8//18CaQ/SwVMRiUtqwbsUlbHkHtQRm32r/Otpzjd4/
vcTshpsPRIcxEib2UMRP6WGjHurC4rd/3pcWlP/GsjA/aGNb9yaNunHBTJzVaqSeiwwYObco
sJi1199wNBePGrZK6WF3XumgA6++kTKEieJ6hSj2amTR80VaYIzKyjCu4SklI7+ouBL/8UsN
ljRrIL8sCLkyBlYjWYNsQR3ZbQIDAQABo4IByzCCAccwHwYDVR0jBBgwFoAUCcDy/AvalNtf
/ivfqJlCz8ngrQAwHQYDVR0OBBYEFEmwhbO6wfSTbflKHMQwSp7HWMGvMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBABgNV
HSAEOTA3MDUGDCsGAQQBsjEBAgEBATAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28u
Y29tL0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3Rp
Z29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEF
BQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JT
QUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGG
F2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMB0GA1UdEQQWMBSBEml2YW5Adm1mYWNpbGl0eS5m
cjANBgkqhkiG9w0BAQsFAAOCAQEAPXjOtK7xHfpAU3HUn5hIlaWUzkbaMI1R8tiefaJsHJks
4dkh/IqQhI+3yCjPybY38NP+ctwgpOZo7ARK/lLKo4+yooYs+5MrwCvP2Kw2RKPp+ZjhJIWX
DVcoVUxkONrVJH/VuTB3zeJDZ9nrODK9D3X1W2+8srQKgDjlx0sLYuBQEwNDEft9Ag9rL4/5
X1nlZJZbR8KWM0BxpHYTi7iGL2Gk8GE+beHDmyCAJHolkcs6G3GXwsp03hm300PGbEVsuWgA
5zHW90OSi/5CnrN15TaOC2yd9nRsobe5ajJAUjvCyVrl+tLmiM/KYJ24/R5Mb+CF6HhhiUa4
IwbWGZZbgzCCBhAwggP4oAMCAQICEE2ULBDUO+CUCcWBLTorBk8wDQYJKoZIhvcNAQEMBQAw
gYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkg
Q2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1
c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIz
MTIzNTk1OVowgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1
U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0Ew
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKPO2UCkH/3vlGuejWO+bakr8rEE6q
GryCvb4mHCkqKtLNnFCBP22ULvOXqGfV9eNKjkypdR8i0yW2sxpepwRIm4rx20rno0JKuriI
Mpoqr03E5cWapdfbM3wccaNDZvZe/S/Uvk2TUxA8oDX3F5ZBykYQYVRR3SQ36gejH4v1pXWu
N82IKPdsmTqQlo49ps+LbnTeef8hNfl7xZ8+cbDhW5nv0qGPVgGt/biTkR7WwtMewu2mIr06
MbiJBEF2rpn9OVXH+EYB7PmHfpsEkzGp0cul3AhSROpPyx7d53Q97ANyH/yQc+jl9mXm7UHR
5ymr+wM3/mwIbnYOz5BTk7kTAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA
4dibwJ3ysgNmyzAdBgNVHQ4EFgQUCcDy/AvalNtf/ivfqJlCz8ngrQAwDgYDVR0PAQH/BAQD
AgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MBEGA1UdIAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0
cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYB
BQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVz
dC5jb20wDQYJKoZIhvcNAQEMBQADggIBAEFEdQCrOcIV9d6OlW0ycWiMAN0X13ocEDiQyOOx
vRcxkfO244K0oX7GzCGHYaqRbklCszzNWVT4DZU/vYrLaeVEDUbCYg+Ci7vhNn9dNqscbzN0
xKBoOuRVjPPWDechU70geT3pXCxpwi8EXwl+oiz7xpYfY99JSs3E/piztTSxljHitcPr5yoW
r9lbkFR8KU3+uGTZ11BfKfuSSaRrZFBv133SeY0d2AqvB9Dj2ZDaFZA0OQkkhfAqNgDpVRH9
9lQV4JSKx0N7/QAEtMj6OF5dRXV6hhXuU3A0Eql4d0247oBpxvnfcmV95QfG8HP059hZSJe7
T2wwC+IzXVDQO4xnnvrQJ07ZWemxc/grFpgiG+o+pQxapF1bKftysi02Rl6uhdp5wbTeLeYz
t2SI9oKSChwGDQQFixtkNnxuwbdrTwvASwvViDPdIGzIQJrTBqriE5/9nzkXbDZmld8/7Dyr
iJ/A73RIZllX4dH8mHqsRpU8NEX8IQZWpHWGK5A5nVgvl7MxNfRlIvCvKZQTSnCL8oNqJgHX
m6zCB4gBwDonM8V/2kuQAUVazVA3I376eIWGwzjuqh3H88v7mNHzubLHm5h0ERCSQNz6UoHV
Zy3q5xeqbYSaxpDQz3lCNObL6sNaOQNh3DcyzqZJYTcGfuLlmC3AIteAAh7lbybJszYnMYIE
MjCCBC4CAQEwgaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UE
AxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0ECEAFLMYux7JhpLlD7LxbMM7cwDQYJYIZIAWUDBAIBBQCgggJXMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTAwODE0MTEzOFowLwYJKoZIhvcNAQkE
MSIEIG4YlqSncjNIsNykHT9ekTGYLNUUS/uklDSjthAdRLzPMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgbwGCSsGAQQBgjcQBDGB
rjCBqzCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0
aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQAUsx
i7HsmGkuUPsvFswztzCBvgYLKoZIhvcNAQkQAgsxga6ggaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
D1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRp
Y2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEAFLMYux7JhpLlD7LxbMM7cwDQYJKoZIhvcN
AQEBBQAEggEAVje5MQUA324HiCBTTt0rySCLLpHgBOETyBTdXP9iK9L9NjW3QSOUTqGvTJjb
shYSr3FQ8pVKJOIdAYcMey6tn7BfOCFVHjstpOW0i8ld857tt9PJeAwJK7S86miBdHOOF8AK
qamJWtkPi3TQCTMmENaDx4ddQ4146VfynRonAVNAIlKOO8br0dJJ4Uk7t/TPbVDMXS1ihmbc
ZOGbpiylJlCtYJGCPy/UOeXXgGXbpsbGSCZKoHoSquyBfKhe9PIQBIYROEynXupjVfluABIF
RTbqJIiFgm6Rok6WUpwQ0msh44RL2UtAIvFEzjzSNisalnhEd/WPJU2CkTDQ34Sq4gAAAAAA
AA==
--------------ms050600060405090406020207--

